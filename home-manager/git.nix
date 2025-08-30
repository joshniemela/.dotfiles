{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Joshua Niemelä";
    userEmail = "josh@jniemela.dk";

    extraConfig = {
      safe.directory = "/home/josh/.dotfiles";
    };
  };
}
