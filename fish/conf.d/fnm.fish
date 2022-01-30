if type -q fnm
    fnm env --use-on-cd | source

    if test -n "$NVM_BIN"
        set -Ux NVM_BIN $FNM_DIR/node-versions/(fnm current)/installation/bin
    end

    if test -n "$NPM_GLOBAL_PACKAGE_PATH"
        set -Ux NVM_BIN $FNM_DIR/node-versions/(fnm current)/installation/lib
    end
end
