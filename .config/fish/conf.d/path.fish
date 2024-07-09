#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-07-09      │ Git     │
#└──────────────┴─────────────────┴─────────┘

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end
