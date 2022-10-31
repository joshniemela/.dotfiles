#!/bin/sh
pushd ~/.dotfiles
doas nix flake update && doas nixos-rebuild switch  --upgrade --flake .#
popd
