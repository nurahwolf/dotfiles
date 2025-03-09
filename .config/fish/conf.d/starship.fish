if type -q starship
    source (starship init fish --print-full-init | psub)
end
