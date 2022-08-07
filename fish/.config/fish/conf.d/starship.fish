# Use starship as a prompt when it is available
if type -q starship
    starship init fish | source
end
