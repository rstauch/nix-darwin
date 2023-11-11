{pkgs, ...}: let
in {
  home.packages = [
    # fzf preview
    pkgs.lesspipe
    pkgs.eza
    pkgs.mdcat
  ];

  home.sessionVariables = {
    BAT_PAGER = "${pkgs.less}/bin/less -RF --mouse --wheel-lines=3";
  };

  programs.bat = {
    enable = true;
    config.theme = "TwoDark";
  };

  # history = CTRL + R
  # subdirs filesearch = CTRL + T
  # alternativ: cd ** + TAB bzw cat ** + TAB um fuzzy search zu öffnen
  # enter subdir = ALT+C
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    fileWidgetOptions = [
      "--height=70% --preview '${pkgs.lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:1000 {}'"
    ];
  };

  # cdi = interactive, auch triggerbar mit cd xxx<SPACE><TAB>
  # cdi bla / = search from root dir
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    # replace cd command
    options = ["--cmd cd"];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
    };
    sessionVariables = {
      # should disable path on the right hand side
      RPROMPT = "";
    };
    initExtra = ''
      unsetopt BEEP
      unsetopt LIST_BEEP
      unsetopt HIST_BEEP
      unsetopt notify # Don't print status of background jobs until a prompt is about to be printed
      setopt INC_APPEND_HISTORY
      setopt globdots

      unset RPS1 RPROMPT

      # https://github.com/Freed-Wu/fzf-tab-source
      zstyle ':fzf-tab:complete:*' fzf-min-height 1000
      # preview directory's content with exa when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.lib.getExe pkgs.eza} -1ha --color=always --group-directories-first $realpath'
      # enable preview with bat/cat/less
      zstyle ':fzf-tab:complete:(bat|cat|less):*' fzf-preview '${pkgs.lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:1000 $realpath'

      eval "$(direnv hook zsh)"

      # only relevant if iterm2 shell integration was triggered
      source "$HOME/.iterm2_shell_integration.zsh"
    '';
    sessionVariables = {DEFAULT_USER = "rstauch";};
    autocd = true;

    shellAliases = {
      l = "ls -lah --color=auto";
      lsl = "${pkgs.lib.getExe pkgs.eza} -la --group-directories-first --color=auto --no-user --no-permissions --header --no-time";
      cls = "clear";
      c = "clear";
      b = "${pkgs.lib.getExe pkgs.bat}";
      j = "${pkgs.lib.getExe pkgs.just}";
      e = "${pkgs.lib.getExe pkgs.vscode}";
      # hme = "cd /Users/rstauch/projects/int/nix/ && ${pkgs.lib.getExe pkgs.vscode} .";
      hme = "cd /Users/rstauch/projects/int/nix/ && code .";
      # dot = "cd /Users/rstauch/projects/int/dotfiles && ${pkgs.lib.getExe pkgs.vscode} .";
      dot = "cd /Users/rstauch/projects/int/dotfiles && code .";

      # TODO: pfad dynamisch gestaltbar ? bzw. mit setup script koordinieren
      nixswitch = "darwin-rebuild switch --flake /Users/rstauch/projects/int/nix/.# && hm-gc && refresh";
      nixup = "cd /Users/rstauch/projects/int/nix && git add . && hm-gc && nix-channel --update && nix flake update && nixswitch && git add .";
      hm-gc = "nix-collect-garbage";
      hmu = "upd-darwin && nixup";
      upd-darwin = "brew update --force && brew upgrade --greedy && nix-channel --update darwin && darwin-rebuild changelog";

      tree = "${pkgs.lib.getExe pkgs.eza} --tree --level 3 --all --group-directories-first --no-permissions --no-time";
      bottom = "${pkgs.lib.getExe pkgs.bottom}";
      br = "br --cmd ':open_preview'";

      md = "${pkgs.lib.getExe pkgs.glow}";
      refresh = "source /Users/rstauch/.zshrc";
      gu = "git fetch && git pull";
    };

    history = {
      size = 100000;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
    };
    plugins = [
      {
        # Replace zsh's default completion selection menu with fzf!
        # configuration https://github.com/Aloxaf/fzf-tab#configure
        name = "fzf-tab";
        src = with pkgs;
          fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            # bei revisions update sha256 auskommentieren und nixup ausführen um korrekten sha256 zu bekommen
            rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
            sha256 = "sha256-dPe5CLCAuuuLGRdRCt/nNruxMrP9f/oddRxERkgm1FE=";
          };
      }
    ];

    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
      plugins = [
        "git"

        "sudo" # press esc twice.

        # option + left = previous dir
        # option + right = undo
        # option + up = parent dir
        # option + down = first child dir
        "dirhistory"

        "colored-man-pages"

        "zoxide"

        # mvnci = mvn clean install
        # mvncist = mvn clean install -DskipTests
        "mvn"

        # 1password
        # adb
        # aws
        # gcloud
        "docker"
        # docker-compose ?
        # gitflow ?

        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/helm
        "helm"

        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/minikube
        # "minikube"

        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl
        "kubectl"
      ];
      # theme = "simple";
      # theme = "agnoster";
      custom = "${./themes}";
      theme = "agnoster2";
    };
  };
}
