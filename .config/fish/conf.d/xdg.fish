#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-02-10      │ Git     │
#└──────────────┴─────────────────┴─────────┘

# XDG USER DIRECTORIES
set -x XDG_CACHE_HOME	"$HOME/.cache"		# For user-specific non-essential (cached) data (analogous to /var/cache).
set -x XDG_CONFIG_HOME	"$HOME/.config"		# For user-specific configurations (analogous to /etc).
set -x XDG_DATA_HOME	"$HOME/.local/share"	# For user-specific data files (analogous to /usr/share).
set -x XDG_STATE_HOME	"$HOME/.local/state"	# For user-specific state files (analogous to /var/lib).

# Setting environment variables to try and stop other programs from causing hell
set -x _JAVA_OPTIONS		"-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
set -x CUDA_CACHE_PATH		"$XDG_CACHE_HOME/cuda"
set -x DOTNET_CLI_HOME		"$XDG_DATA_HOME/dotnet"
set -x GNUPGHOME		"$XDG_DATA_HOME/gnupg"
set -x GOPATH			"$XDG_DATA_HOME/go"
set -x NUGET_PACKAGES		"$XDG_CACHE_HOME/NugetPackages"
set -x STARSHIP_CACHE		"$XDG_CACHE_HOME/starship"
set -x STARSHIP_CONFIG		"$XDG_CONFIG_HOME/starship.toml"
set -x VSCODE_EXTENSIONS	"$XDG_DATA_HOME/vscode/extensions"
set -x WGETRC			"$XDG_CONFIG_HOME/wgetrc"
set -x XAUTHORITY		"$XDG_RUNTIME_DIR/Xauthority"
set -x VSCODE_PORTABLE		"$XDG_DATA_HOME/vscode"
set -x OLLAMA_MODELS		"$XDG_DATA_HOME/ollama/models"
set -x VSCODE_PORTABLE		"$XDG_DATA_HOME/vscode"

# Rust specific environment variables
set -x CARGO_HOME		"$XDG_DATA_HOME/cargo"
set -x CARGO_CONFIG_HOME	"$XDG_CONFIG_HOME/cargo"
set -x CARGO_DATA_HOME		"$XDG_DATA_HOME/cargo"
set -x CARGO_BIN_HOME		"$CARGO_DATA_HOME/bin"
set -x CARGO_CACHE_HOME		"$XDG_CACHE_HOME/cargo"
set -x RUSTUP_HOME		"$XDG_DATA_HOME/rustup"
set -x RUSTUP_CONFIG_HOME	"$XDG_CONFIG_HOME/rustup"
set -x RUSTUP_CACHE_HOME	"$XDG_CACHE_HOME/rustup"

# Alias for pesky programs
if type -q code
    abbr -a 'code'	'code --extensions-dir "$XDG_DATA_HOME/vscode"'
end
