#!/usr/bin/env fish
set LOCAL_PATH "/.snapshots" # The local path where snapshots live
set SNAPSHOT_PREFIX "SECURESERVER.NASA.LOCAL" # A custom snapshot prefix
set TARGET "MAINFRAME.nasa.local" # The target to send snapshots to
set TARGET_PATH "/run/media/system/BIGSTORAGE" # The target path to send snapshots to

# Colours
set COLOUR_GREEN (set_color green)
set COLOUR_RED (set_color red)
set COLOUR_YELLOW (set_color yellow)
set COLOUR_RESET (set_color normal)

# Define an alphabetically sorted array of snapshot names and their paths
set snapshots \
    "ROOT:/root" \
    "HOME:/home"

# Check if the correct number of arguments are passed
if test (count $argv) -lt 2
    echo "$COLOUR_RED [X] Usage: \$argv[0] <CURRENT_DATE> <PREVIOUS_DATE>"
    exit 1
end

# Assign the arguments to variables
set current_date $argv[1]
set previous_date $argv[2]

# Assign optional SNAPSHOT_PREFIX
if test (count $argv) -ge 3
    set SNAPSHOT_PREFIX $argv[3]
end

# Create and send root snapshot
if test -e /mnt/"$current_date"_"$SNAPSHOT_PREFIX"
    echo "$COLOUR_YELLOW [X]: Snapshot "$current_date"_"$SNAPSHOT_PREFIX" already exists. Skipping creation. $COLOUR_RESET"
else
	# Create the read-only snapshot if it doesn't exist
	btrfs subvolume snapshot -r / /mnt/"$current_date"_"$SNAPSHOT_PREFIX"

	# Ensure it was created successfully, otherwise exit
	if test $status -ne 0
		echo "$COLOUR_RED [X]: Failed to create snapshot for "$current_date"_"$SNAPSHOT_PREFIX" $COLOUR_RESET"
		exit 1
	end

	# Send the snapshot incrementally
        btrfs send --proto 2 --compressed-data -p /mnt/"$previous_date"_"$SNAPSHOT_PREFIX" /mnt/"$current_date"_"$SNAPSHOT_PREFIX" | pv | ssh $TARGET btrfs receive $TARGET_PATH

        # Ensure that the snapshot was sent successfully
        if test $status -ne 0
            echo "$COLOUR_RED [X]: Failed to send snapshot "$current_date"_"$SNAPSHOT_PREFIX" $COLOUR_RESET"
            exit 1
        end

        echo "$COLOUR_GREEN [✓]: Snapshot "$current_date"_"$SNAPSHOT_PREFIX" has been sent! $COLOUR_RESET"
end

# Loop through each snapshot
for snapshot in $snapshots
    # Split the snapshot name and path
    set snapshot_name (echo $snapshot | cut -d':' -f1)
    set snapshot_path (echo $snapshot | cut -d':' -f2)

    # Define the snapshot target path
    set target_snapshot /mnt/"$current_date"_"$SNAPSHOT_PREFIX"_$snapshot_name

    # Check if the snapshot already exists
    if test -e $target_snapshot
        echo "$COLOUR_YELLOW [X]: Snapshot "$current_date"_"$SNAPSHOT_PREFIX"_$snapshot_name already exists. Skipping creation. $COLOUR_RESET"
    else
        # Create the read-only snapshot if it doesn't exist
        btrfs subvolume snapshot -r $snapshot_path $target_snapshot

        # Ensure it was created successfully, otherwise exit
        if test $status -ne 0
            echo "$COLOUR_RED [X]: Failed to create snapshot for $snapshot_path $COLOUR_RESET"
            exit 1
        end

        # Send the snapshot incrementally
        btrfs send --proto 2 --compressed-data -p /mnt/"$previous_date"_"$SNAPSHOT_PREFIX"_$snapshot_name /mnt/"$current_date"_"$SNAPSHOT_PREFIX"_$snapshot_name | pv | ssh $TARGET btrfs receive $TARGET_PATH

        # Ensure that the snapshot was sent successfully
        if test $status -ne 0
            echo "$COLOUR_RED [X]: Failed to send snapshot $snapshot_path $COLOUR_RESET"
            exit 1
        end

        echo "$COLOUR_GREEN [✓]: Snapshot "$current_date"_"$SNAPSHOT_PREFIX"_$snapshot_name has been sent! $COLOUR_RESET"
    end
end
