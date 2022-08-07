# Enable Vi keybindings
fish_vi_key_bindings

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/lukexaviersymington/.nvm/versions/node/v12.19.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/lukexaviersymington/Development/cash-processor/node_modules/tabtab/.completions/slss.fish ]; and . /Users/lukexaviersymington/Development/cash-processor/node_modules/tabtab/.completions/slss.fish

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/lxs/.ghcup/bin $PATH # ghcup-env