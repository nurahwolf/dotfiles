#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-07-09      │ Git     │
#└──────────────┴─────────────────┴─────────┘

# Format man pages, taken from https://github.com/CachyOS/cachyos-fish-config
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
