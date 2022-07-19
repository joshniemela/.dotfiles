#!/bin/sh
pushd ~/nixfiles
nix build .#homeManagerConfigurations.josh.activationPackage
./result/activate
popd
