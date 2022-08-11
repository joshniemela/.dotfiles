#!/bin/sh
pushd ~/.dotfiles
doas nixos-rebuild switch --upgrade --flake .#
popd
