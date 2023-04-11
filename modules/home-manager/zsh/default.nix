{pkgs, ...}: let
in {
  home.packages = [
    # fzf preview
    pkgs.lesspipe
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
    # would replace the cd command (doesn't work on Nushell / POSIX shells).
    options = ["--cmd cd"];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
      unsetopt BEEP
      unsetopt LIST_BEEP
      unsetopt HIST_BEEP
      unsetopt notify # Don't print status of background jobs until a prompt is about to be printed
      setopt INC_APPEND_HISTORY
      setopt globdots
      # https://github.com/Freed-Wu/fzf-tab-source
      zstyle ':fzf-tab:complete:*' fzf-min-height 1000
      # preview directory's content with exa when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.lib.getExe pkgs.exa} -1ha --color=always --group-directories-first $realpath'
      # enable preview with bat/cat/less
      zstyle ':fzf-tab:complete:(bat|cat|less):*' fzf-preview '${pkgs.lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:1000 $realpath'

      eval "$(direnv hook zsh)"
    '';
    autocd = true;

    shellAliases = {
      ls = "ls --color=auto -F";

      nixswitch = "darwin-rebuild switch --flake ~/projects/int/nix/.#";
      nixup = "pushd ~/projects/int/nix; nix flake update; nixswitch; popd";
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
            rev = "69024c27738138d6767ea7246841fdfc6ce0d0eb";
            sha256 = "sha256-yN1qmuwWNkWHF9ujxZq2MiroeASh+KQiCLyK5ellnB8=";
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
        # 1password
        # adb
        # aws
        # gcloud
        # docker
        # docker-compose ?
        # gitflow ?
      ];
      theme = "simple";
    };
  };
}
