#┌──────────────┬─────────────────┬─────────┐
#│ Version      │ Last Modified   │ Manager │
#├──────────────┼─────────────────┼─────────┤
#│ 0.0.1        │ 2024-07-09      │ Git     │
#└──────────────┴─────────────────┴─────────┘

# Please for the love of everything do not run this in non interactive I will cry
if not status is-interactive
    exit
end

function fish_greeting
    # If fastfetch is defined, use that
    if type -q fastfetch
        fastfetch
    else
        # Otherwise, no greeting at all
        set --erase fish_greeting
    end
end
