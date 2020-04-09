# Enable Vi keybindings
fish_vi_key_bindings

# Enable use of nix package manager
bass source ~/.nix-profile/etc/profile.d/nix{,-daemon}.sh

# Bootstrap `fisher` and install listed plugins
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Launch keychain on login
if status --is-interactive
    keychain --eval --quiet --agents ssh -Q id_rsa | source
end

# Source relevant keychain files
begin
    set -l HOSTNAME (hostname)
    if test -f ~/.keychain/$HOSTNAME-fish
        source ~/.keychain/$HOSTNAME-fish
    end
end
