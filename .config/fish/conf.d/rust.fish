#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-02-10      │ Git     │
#└──────────────┴─────────────────┴─────────┘

set -U RUSTFLAGS '-C target-cpu=native' # Compile to native code, this enables things like SSE!
