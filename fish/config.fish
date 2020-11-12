# Enable Vi keybindings
fish_vi_key_bindings

# Enable use of nix package manager
if test -d ~/.nix-profile
    bass source ~/.nix-profile/etc/profile.d/nix{,-daemon}.sh
end

# Seccl specific
if test -d ~/.seccl
    bass source ~/.seccl/env.sh
end

# Bootstrap `fisher` and install listed plugins
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Launch keychain on login
if type -q keychain && status is-interactive
    keychain --eval --clear --quiet --agents ssh id_rsa | source
end

# Source relevant keychain files
begin
    set -l HOSTNAME (hostname)
    if test -f ~/.keychain/$HOSTNAME-fish
        source ~/.keychain/$HOSTNAME-fish
    end
end

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
