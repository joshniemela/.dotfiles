#!/bin/sh
pushd ~/.dotfiles
nix build .#nixosConfigurations.liveISO.config.system.build.isoImage
popd
