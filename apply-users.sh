#!/bin/sh
pushd ~/.dotfiles/
nix build .#homeManagerConfigurations.josh.activationPackage
./result/activate
popd
