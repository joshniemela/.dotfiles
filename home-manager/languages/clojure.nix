{pkgs, ...}:
{
    home.packages = with pkgs; [
        openjdk
        leiningen
        clojure
    ]:
}