# Enable Vi keybindings
fish_vi_key_bindings

# Use starship as a prompt when it is available
if type -q starship
    starship init fish | source
end

# Use zoxide as a navigator when it is available
if type -q zoxide
    zoxide init fish | source
end

# Enable use of nix package manager
if type -q replay && test -d ~/.nix-profile
    replay source ~/.nix-profile/etc/profile.d/nix{,-daemon}.sh
end

# Enable use of node version manager
if test -d ~/.nvm && type -q nvm
    load_nvm
end

# Seccl specific
if type -q replay && test -d ~/.seccl
    replay source ~/.seccl/env.sh
end

# Bootstrap `fisher` and install listed plugins
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Launch keychain on login
if type -q keychain && status is-interactive
    keychain --eval --quiet -Q --inherit local --agents ssh id_rsa | source

    # Source relevant keychain files
    begin
        set -l HOSTNAME (hostname)
        if test -f ~/.keychain/$HOSTNAME-fish
            source ~/.keychain/$HOSTNAME-fish
        end
    end
end

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/lukexaviersymington/Development/cash-processor/node_modules/tabtab/.completions/slss.fish ]; and . /Users/lukexaviersymington/Development/cash-processor/node_modules/tabtab/.completions/slss.fish
