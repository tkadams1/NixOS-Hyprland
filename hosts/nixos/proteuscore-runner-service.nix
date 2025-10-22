# See the steps below on how to set up the ProteusCore runner using this file
# STEP 1: Copy this file into your /etc/nixos directory and import it into your configruation.nix file
{ config, pkgs, ... }:
{
  imports = [
    /home/taylor/Downloads/ProteusCore_1.5.0_944_nix_x86/proteuscore.nix              # STEP 2: CHANGE THE PATH TO THE LOCATION OF YOUR PROTEUSCORE.NIX file
  ];

  environment.systemPackages = with pkgs; [
    # Your existing packages...
    proteuscore
  ];

  environment.etc = {
    # License configuration
    "tocaro/SharedData/license.key" = {
      text = "WJ88-53XD-2H33-M6PR";                                         # STEP 3: Add your license key (dashes included, all caps)
      mode = "0644";
    };
    
    # Navigation data
    "tocaro/SharedData/target_linux.dat" = {
      source = "${pkgs.proteuscore}/StaticData/target_linux.dat";
      mode = "0644";
    };
    
    # Geographic data
    "tocaro/SharedData/world_water.mbtiles" = {
      source = "${pkgs.proteuscore}/StaticData/world_water.mbtiles";
      mode = "0644";
    };
    
    # Application configuration
    "tocaro/SharedData/config.json" = {
      source = "${pkgs.proteuscore}/StaticData/config.json";
      mode = "0644";
    };
    
    # Demo data
    "tocaro/SharedData/logs/IBEX_demo.bin" = {
      source = "${pkgs.proteuscore}/StaticData/logs/IBEX_demo.bin";
      mode = "0644";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      5000 # Websocket
      8080 # HTTP API
    ];
  };

  systemd.services.proteuscore = {
    description = "ProteusCore Application";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.proteuscore}/bin/ProteusCore_EXN";
      Restart = "always";
      RestartSec = 5;
      Environment = "HOME=/home/tocaro";
    };
  };
}
    