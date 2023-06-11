{pkgs, ...}:
{
    home.packages = with pkgs; [
        leiningen
        clojure-lsp
        clojure
        babashka
    ];
}