{
  config,
  lib,
  pkgs,
  ...
}: {
  enableKeyboard = pkgs.writeShellScriptBin "enableKeyboard" ''
        xinput reattach 'AT Translated Set 2 keyboard' 'Virtual core keyboard'
      '';
  disableKeyboard = pkgs.writeShellScriptBin "disableKeyboard" ''
        xinput float "AT Translated Set 2 keyboard"
      '';
}
