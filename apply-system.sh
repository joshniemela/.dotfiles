#!/bin/sh
pushd ~/nixfiles
doas nixos-rebuild switch --flake .#
popd
