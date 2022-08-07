# Enable use of nix package manager
if type -q replay && test -d ~/.nix-profile
    replay source ~/.nix-profile/etc/profile.d/nix{,-daemon}.sh
end
