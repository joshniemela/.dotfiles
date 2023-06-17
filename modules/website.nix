{
  config,
  pkgs,
  lib,
  ...
}: {
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
    virtualHosts."disku.jniemela.dk" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:5000";
        extraConfig =
          "proxy_ssl_server_name on;" +
          "proxy_pass_header Authorization;";
      };
      locations."/api" = {
        proxyPass = "http://localhost:3000";
        extraConfig =
          "proxy_ssl_server_name on;" +
          "proxy_pass_header Authorization;";
      };
    };
  };
}
