{
  config,
  pkgs,
  lib,
  ...
}: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE josh WITH LOGIN PASSWORD 'md531ee9d3a717108aa7e4dec54405d8184'
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO josh;
    '';
  };
}
