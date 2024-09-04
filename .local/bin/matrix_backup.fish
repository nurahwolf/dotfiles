#!/usr/bin/env fish
set SNAPSHOT_PREFIX "MATRIX.WOLFO.TECH" # A custom snapshot prefix
set TARGET "luro.lunar.cloud" # The target to send snapshots to
set TARGET_PATH "/run/media/system/Lead/.snapshots" # The target path to send snapshots to

# Check if the correct number of arguments are passed
if test (count $argv) -lt 2
    echo "Usage: \$argv[0] <CURRENT_DATE> <PREVIOUS_DATE>"
    exit 1
end

# Assign the arguments to variables
set current_date $argv[1]
set previous_date $argv[2]

# Assign optional SNAPSHOT_PREFIX
if test (count $argv) -ge 3
    set SNAPSHOT_PREFIX $argv[3]
end

# Define an alphabetically sorted array of snapshot names and their paths
set snapshots \
    "ROOT:/root" \
    "HOME:/home" \
    "MATRIX:/matrix" \
    "MATRIX-POSTGRES:/matrix/postgres" \
    "OPT:/opt" \
    "SRV:/srv" \
    "USR-LOCAL:/usr/local" \
    "VAR:/var" \
    "VAR-LOG:/var/log"

# Create and send root snapshot
if test -e /mnt/"$current_date"_"$SNAPSHOT_PREFIX"
    echo "Snapshot "$current_date"_"$SNAPSHOT_PREFIX" already exists. Skipping creation."
else
	# Create the read-only snapshot if it doesn't exist
	btrfs subvolume snapshot -r / /mnt/"$current_date"_"$SNAPSHOT_PREFIX"

	# Ensure it was created successfully, otherwise exit
	if test $status -ne 0
		echo "Failed to create snapshot for "$current_date"_"$SNAPSHOT_PREFIX""
		exit 1
	end

	# Send the snapshot incrementally
        btrfs send --proto 2 --compressed-data -p /mnt/"$previous_date"_"$SNAPSHOT_PREFIX" /mnt/"$current_date"_"$SNAPSHOT_PREFIX" | pv | ssh $TARGET btrfs receive $TARGET_PATH

        # Ensure that the snapshot was sent successfully
        if test $status -ne 0
            echo "Failed to send snapshot $snapshot_path"
            exit 1
        end
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
        echo "Snapshot "$current_date"_"$SNAPSHOT_PREFIX"_$snapshot_name already exists. Skipping creation."
    else
        # Create the read-only snapshot if it doesn't exist
        btrfs subvolume snapshot -r $snapshot_path $target_snapshot

        # Ensure it was created successfully, otherwise exit
        if test $status -ne 0
            echo "Failed to create snapshot for $snapshot_path"
            exit 1
        end

        # Send the snapshot incrementally
        btrfs send --proto 2 --compressed-data -p /mnt/"$previous_date"_"$SNAPSHOT_PREFIX"_$snapshot_name /mnt/"$current_date"_"$SNAPSHOT_PREFIX"_$snapshot_name | pv | ssh $TARGET btrfs receive $TARGET_PATH

        # Ensure that the snapshot was sent successfully
        if test $status -ne 0
            echo "Failed to send snapshot $snapshot_path"
            exit 1
        end
    end
end
