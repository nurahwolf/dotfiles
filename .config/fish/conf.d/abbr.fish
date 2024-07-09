#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-07-09      │ Git     │
#└──────────────┴─────────────────┴─────────┘

# Don't set these up if we are not in an interactive session.
# Sure, abbr is safe to use non-interactive, but this does save a few cycles where its not needed.

if not status is-interactive
    exit
end

# 'utility' tweaks:
abbr -a 'print_path' 'echo -e $PATH//:/\\n'   # Print each PATH entry on a separate line
abbr -a 'tb'	'nc termbin.com 9999' # Upload stuff to termbin.com, requires netcat

# 'ls' tweaks:
if type -q eza
    abbr -a 'ls'	'eza -al --color=always --group-directories-first --icons'	# preferred listing
    abbr -a 'la'	'eza -a --color=always --group-directories-first --icons'	# all files and dirs
    abbr -a 'll'	'eza -l --color=always --group-directories-first --icons' 	# long format
    abbr -a 'lt'	'eza -aT --color=always --group-directories-first --icons'	# tree listing
    abbr -a 'l.'	"eza -a | grep -e '^\.'"					# show only dotfiles
else
    abbr -a 'ls'        'ls --color=auto'           # Colours for `ls`! Though I normally use `exa` where I can!
end

# 'systemd' tweaks:
if type -q journalctl
    abbr -a 'jctl'	'journalctl -p 3 -xb'	# Get the error messages from journalctl
end

# 'cd' tweaks. In reality, this is just me being lazy.
abbr -a '.....'	'cd ../../../../'	# Back four directories
abbr -a '....'	'cd ../../..'		# Back three directories
abbr -a '...'	'cd ../..'		# Back two directories
abbr -a '..'	'cd ..'			# Back a directory

# 'vim' tweaks, in reality just use nvim.
if type -q nvim
    abbr -a 'vim'       'nvim'
    abbr -a 'vi'        'nvim'
end

# 'grep' tweaks:
abbr -a 'grep'      'grep --color=auto'          # Add colour to 'grep'!

## TODO: Can I avoid hardcoding run0?
if type -q dmidecode
    abbr -a 'memspeed'  'run0 dmidecode --type 17'  # Print memory information only using `dmidecode`
end
