# Add to your configuration.nix or a separate module

{ pkgs, ... }:

{
  # Install wayvnc
  environment.systemPackages = with pkgs; [
    wayvnc
    waypipe  # Optional: for better performance
  ];

  # Open VNC port in firewall 
  networking.firewall.allowedTCPPorts = [ 5900 ];

  # Optional: Create a systemd user service for wayvnc
  systemd.user.services.wayvnc = {
    description = "wayvnc VNC server for Wayland";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ]; 
    serviceConfig = {
      ExecStart = "${pkgs.wayvnc}/bin/wayvnc -o eDP-1 0.0.0.0 5900";
      Restart = "on-failure";
    };
  };
}