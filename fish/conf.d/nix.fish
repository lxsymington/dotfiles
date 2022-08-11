# Enable use of nix package manager
if type -q replay && test -d ~/.nix-profile/etc/profile.d
    replay source ~/.nix-profile/etc/profile.d/nix{,-daemon}.sh
end

if type -q replay && test -d /nix/var/nix/profiles/default/etc/profile.d
    replay source /nix/var/nix/profiles/default/etc/profile.d/nix{,-daemon}.sh
end
