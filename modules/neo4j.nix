{
  config,
  pkgs,
  lib,
  ...
}: {
  services.neo4j = {
    enable = true;
    http.enable = true;
    https.enable = false;
    defaultListenAddress = "0.0.0.0";
    bolt.tlsLevel = "DISABLED";
    directories = {
      home = "/home/josh/.neodata/";
      #certificates = "/home/josh/.neodata/certs";
    };
  };
}
