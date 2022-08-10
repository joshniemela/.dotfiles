#!/bin/sh
pushd ~/.dotfiles
doas nixos-rebuild switch --flake .#
popd
