{ config, pkgs, lib, ... }:
{   
    security.acme.acceptTerms = true;
    security.acme.defaults.email = "josh@jniemela.dk";
    services.nginx = {
        enable = true;
        virtualHosts."jniemela.dk" = {
          enableACME = true;
          forceSSL = true;
          locations."jniemela.dk".index = "home.html";
          extraConfig = ''
            if ($request_uri ~ ^/(.*)\.html) {
                return 302 /$1;
                }
                try_files $uri $uri.html $uri/ =404;
          '';
          root = "/var/www";
        };
    };
}
