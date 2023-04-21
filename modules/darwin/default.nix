# https://daiderd.com/nix-darwin/manual/index.html
{pkgs, ...}: let
in {
  # TODO: ???
  services.activate-system.enable = true;

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  programs.nix-index.enable = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

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

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  security.pam.enableSudoTouchIdAuth = true;

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  services.nix-daemon.enable = true;
  system.defaults = {
    dock = {
      autohide = false;

      # TODO: Wert anpassen
      tilesize = 64;
    };
    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    loginwindow = {
      GuestEnabled = false;
    };

    # Finder
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllFiles = true;

    # keyboard
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;

    # Mouse
    NSGlobalDomain."com.apple.swipescrolldirection" = false;

    # Other
    NSGlobalDomain.AppleInterfaceStyle = "Dark";

    # disable spelling correction etc
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;

    CustomSystemPreferences = {
      NSGlobalDomain = {
        # scheint nicht zu greifen/funktionieren ?
        # "CGDisableCursorLocationMagnification" = 1;
      };
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        # scheint nicht zu greifen/funktionieren ?
        # "CGDisableCursorLocationMagnification" = 1;
      };
    };

    # TODO: tinting = true tone ?, right click tap, highres

    # https://github.com/mathiasbynens/dotfiles/blob/main/.macos
    # https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
  };

  # TODO: UNGETESTED
  # Disable the “Are you sure you want to open this application?” dialog
  system.defaults.LaunchServices.LSQuarantine = false;

  system.stateVersion = 4;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {
      "1Password for Safari" = 1569813296;
    };
    casks = [
      "linearmouse" # manual: enable start automatically at login, config = /Users/rstauch/.config/linearmouse/linearmouse.json
      "raycast" # pot. binary settings ins homeverzeichnis legen und entsprechend manuell importieren
      "1password"
      "1password-cli"
      "firefox" # manual: login to sync settings, install addons: uBlockOrigin, darkreader, 1password
      "google-chrome"
      "docker" # manual: enable start automatically at login
      "shottr"
      "notion"
      # "betterdisplay" # TODO: requires PAID license
    ];
    taps = ["homebrew/cask" "homebrew/cask-versions" "jbangdev/tap" "quarkusio/tap"];
    brews = ["jbang" "quarkus"];
  };
}
