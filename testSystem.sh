#!/bin/sh
pushd ~/.dotfiles
doas nixos-rebuild test --flake .#
popd
