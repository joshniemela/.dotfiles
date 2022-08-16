#!/bin/sh
nix build .#nixosConfigurations.liveISO.config.system.build.isoImage
