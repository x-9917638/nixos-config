{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = "pkgs.LinuxPackages_latest";
  };

  networking = {
    hostName = "leucine";
    networkmanager.enable = true;
  };

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus32";
    keyMap = "us";
  };

  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    libinput.enable = true;
  };

  users.users.val = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system =  {
    stateVersion = "25.11"; # DO NOT TOUCH
    copySystemConfiguration = true;
  };
}
