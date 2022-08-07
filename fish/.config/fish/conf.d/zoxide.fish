# Use zoxide as a navigator when it is available
if type -q zoxide
    zoxide init fish | source
end
