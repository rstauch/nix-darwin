{ pkgs, ... }: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils pkgs.jq];
    # systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  # fonts.fontDir.enable = true; # DANGER
  # fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  
  services.nix-daemon.enable = true;
  system.defaults = {
    # Dock
    dock.autohide = false;
    
    # Finder
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    
    # keyboard
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;

    # Mouse
    NSGlobalDomain."com.apple.swipescrolldirection" = false;

    # Other
  };
  
  system.stateVersion = 4;
}