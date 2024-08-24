{pkgs, ...}: {
  home.packages = with pkgs; [
    clang
    clang-tools
    gdb
    rustc
    cargo
    rustfmt
    rust-analyzer
  ];
}
