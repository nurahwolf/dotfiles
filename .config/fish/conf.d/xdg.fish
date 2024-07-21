#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-02-10      │ Git     │
#└──────────────┴─────────────────┴─────────┘

# Set XDG base paths, to try and stop things from junking up my home directory
set -U XDG_CACHE_HOME   "$HOME/.cache"
set -U XDG_CONFIG_HOME  "$HOME/.config"
set -U XDG_DATA_HOME    "$HOME/.local/share"
set -U XDG_STATE_HOME   "$HOME/.local/state"

# Setting environment variables to try and stop other programs from causing hell
set -U _JAVA_OPTIONS        "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
set -U CARGO_HOME           "$XDG_DATA_HOME/cargo"
set -U CUDA_CACHE_PATH      "$XDG_CACHE_HOME/cuda"
set -U DOTNET_CLI_HOME      "$XDG_DATA_HOME/dotnet"
set -U GNUPGHOME            "$XDG_DATA_HOME/gnupg"
set -U GOPATH               "$XDG_DATA_HOME/go"
set -U NUGET_PACKAGES       "$XDG_CACHE_HOME/NugetPackages"
set -U RUSTUP_HOME          "$XDG_DATA_HOME/rustup"
set -U STARSHIP_CACHE       "$XDG_CACHE_HOME/starship"
set -U STARSHIP_CONFIG      "$XDG_CONFIG_HOME/starship.toml"
set -U VSCODE_EXTENSIONS    "$XDG_DATA_HOME/vscode/extensions"
set -U WGETRC               "$XDG_CONFIG_HOME/wgetrc"
set -U XAUTHORITY			"$XDG_RUNTIME_DIR/Xauthority"
set -U VSCODE_PORTABLE		"$XDG_DATA_HOME/vscode"

# Alias for pesky programs
if type -q code
    abbr -a 'cdde'	'code --extensions-dir "$XDG_DATA_HOME/vscode"'
end
