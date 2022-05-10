# Use Neovim as the man pager
if type -q nvim && test -n "$MANPAGER"
    set -Ux MANPAGER "nvim +Man!"
end
