if type -q fnm
    fnm env --use-on-cd | source
    set -l FNM_BIN $FNM_DIR/node-versions/(fnm current)/installation/bin
    set -l FNM_LIB $FNM_DIR/node-versions/(fnm current)/installation/lib

    if test -n "$NVM_BIN" -o "$NVM_BIN" != "$FNM_BIN"
        set -Ux NVM_BIN $FNM_BIN
    end

    if test -n "$NPM_GLOBAL_PACKAGE_PATH" -o "$NPM_GLOBAL_PACKAGE_PATH" != "$NVM_BIN"
        set -Ux NPM_GLOBAL_PACKAGE_PATH $FNM_LIB 
    end
end
