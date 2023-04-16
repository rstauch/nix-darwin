# https://daiderd.com/nix-darwin/manual/index.html
{pkgs, ...}: let
in {
  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  programs.nix-index.enable = true;

  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [bash zsh];
    loginShell = pkgs.zsh;

    systemPackages = with pkgs; [
      coreutils
      iterm2
    ];

    systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];
  };
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  security.pam.enableSudoTouchIdAuth = true;

  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  services.nix-daemon.enable = true;
  system.defaults = {
    # Dock
    dock.autohide = false;

    # Finder
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllFiles = true;

    # keyboard
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;

    # Mouse
    NSGlobalDomain."com.apple.swipescrolldirection" = false;

    # Other
    NSGlobalDomain.AppleInterfaceStyle = "Dark"; # darkmode
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false; # spellcheck
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false; # smart-dash
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false; # smart-quotes
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;

    # TODO: tinting = true tone, right click tap

    # https://github.com/mathiasbynens/dotfiles/blob/main/.macos
    # https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
  };

  system.stateVersion = 4;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {}; # TODO: install 1password for safari
    casks = [
      "linearmouse" # manual: enable start automatically at login, config = /Users/rstauch/.config/linearmouse/linearmouse.json
      "raycast" # pot. binary settings ins homeverzeichnis legen und entsprechend manuell importieren
      "1password"
      "1password-cli"
      "firefox" # manual: login to sync settings, install addons: uBlockOrigin, darkreader, 1password
      "google-chrome"
    ];
    taps = ["homebrew/cask" "homebrew/cask-versions" "jbangdev/tap" "quarkusio/tap"];
    brews = ["jbang" "quarkus"];
  };
}
