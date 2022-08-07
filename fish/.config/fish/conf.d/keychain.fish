# Launch keychain on login
if type -q keychain && status is-interactive
    keychain --eval --quiet -Q --inherit local --agents ssh id_ed25519 | source

    # Source relevant keychain files
    begin
        set -l HOSTNAME (hostname)
        if test -f ~/.keychain/$HOSTNAME-fish
            source ~/.keychain/$HOSTNAME-fish
        end
    end
end
