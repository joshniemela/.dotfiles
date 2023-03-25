{
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          persist = true;
          keepEnv = true;
        }
      ];
    };
  };
}
