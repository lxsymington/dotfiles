# Defined in - @ line 1
function nvm --wraps=fnm --description 'alias nvm=fnm'
    set -l initial_node_version (fnm current)

    fnm $argv;

    if test -n "$NPM_GLOBAL_PACKAGE_PATH" -o -n "$NVM_BIN" -o "$initial_node_version" != (fnm current)
        set -Ux NPM_GLOBAL_PACKAGE_PATH (realpath $FNM_DIR/node-versions/(fnm current)/installation/lib)
        set -Ux NVM_BIN (realpath $FNM_DIR/node-versions/(fnm current)/installation/bin)
    end
end
