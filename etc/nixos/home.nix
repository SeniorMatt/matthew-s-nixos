{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    #./plasma.nix
    inputs.nvf.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    ffmpeg # Best convertor
    fish # Shell
    unzip
    wget
    gcc
    nodejs # nvim stuff

    # Applications
    vscodium # Code editor
    steam-run # To run godot builds
    gimp # Image editor
    telegram-desktop # Telegram client
    vesktop # Discord client
    zoom # Zoom
    godot-mono # Yeah...
    aseprite # Aseprite
    github-desktop # Github client
    obsidian # Notes
    kitty # Terminal
    obs-studio # OBS
    davinci-resolve # Davinci resolve
    prismlauncher # The Minecraft launcher
    batmon # TUI battery
    htop # TUI task manager
    audacity # Audio editor
    gamescope # Downscale games
    mpv # Media player

    # Fun stuff :D
    nitch # Fetcher
    neofetch # Fetcher N2
    pipes # Pipes
    cmatrix # Matrix effect
    cbonsai # Bonsai tree
    sl # Fucking train
    cowsay # What does the cow say?
    fortune # Fortune cookie
    asciiquarium # Ascii quarium
    cava # Audio visualizer

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish | source
      zoxide init fish | source
      set -g fish_greeting
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "montys";
  };

  programs.git = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/matthew/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "org.gnome.parlatype.desktop";
      "audio/wav" = "org.gnome.parlatype.desktop";
      "document/pdf" = "papers.desktop";
    };
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };
        preventJunkFiles = true;
        luaConfigPost = ''
          vim.opt.tabstop = 2
          vim.opt.shiftwidth = 2
          vim.opt.expandtab = true
          vim.opt.fillchars = { eob = " "}
          vim.opt.autoindent = false
          vim.opt.smartindent = false
          vim.opt.smarttab = true
          vim.opt.scrolloff = 20;
        '';

        spellcheck = {
          enable = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          #inlayHints.enable = true; this does not show errors and warnings - only types?
          lspkind.enable = true;
          lspconfig.enable = true;
          lightbulb.enable = false;
          lspsaga.enable = false;
          trouble.enable = false;
          lspSignature.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
        };

        diagnostics = {
          enable = true;
          config = {
            underline = true;
            virtual_lines = true;
          };
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;

          bash.enable = true;
          clang.enable = true;
          css.enable = false;
          html.enable = false;
          sql.enable = false;
          java.enable = false;
          kotlin.enable = false;
          ts.enable = true;
          lua.enable = false;
          python.enable = false;
          rust = {
            enable = true;
            lsp.enable = true;
            dap.enable = true;
            format.enable = true;
            crates.enable = true;
          };

          csharp = {
            enable = true;
            lsp = {
              enable = true;
              server = "omnisharp";
            };
            treesitter.enable = true;
          };
          dart = {
            enable = true;
            dap.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            flutter-tools.enable = true;
          };
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = false;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp = {
          enable = true;
          sources = {
            nvim-lsp = "nvim_lsp";
            async-path = "async_path";
          };
        };
        snippets.luasnip.enable = false;

        filetree = {
          neo-tree = {
            enable = true;
            setupOpts.enable_refresh_on_write = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
          nvimBufferline.mappings = {
            closeCurrent = "<leader>x";
            cycleNext = "<tab>";
            cyclePrevious = "<S-tab>";
            moveNext = null;
            movePrevious = null;
            sortByDirectory = null;
            sortByExtension = null;
            sortById = null;
          };
        };

        treesitter = {
          context = {
            enable = true;
            setupOpts.max_lines = 3;
          };
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
          git-conflict.enable = true;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = false;
        };

        notify = {
          nvim-notify.enable = false;
        };

        projects = {
          project-nvim.enable = false;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          icon-picker.enable = false;
          surround.enable = false;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap = {
              enable = true;
              mappings = {
                leapBackwardTo = "S";
                leapForwardTo = "s";
              };
            };
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
          };
        };

        notes = {
          obsidian.enable = false;
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = false;
          noice.enable = false;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          fastaction.enable = true;
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };

        keymaps = [
          {
            mode = ["n" "v" "i"];
            key = "<C-n>";
            action = "<cmd>Neotree toggle left<CR>";
          }
          {
            mode = "i";
            key = "jk";
            action = "<ESC>";
          }
          {
            mode = "n";
            key = "<C-h>";
            action = "<C-w>h";
          }
          {
            mode = "n";
            key = "<C-j>";
            action = "<C-w>j";
          }
          {
            mode = "n";
            key = "<C-k>";
            action = "<C-w>k";
          }
          {
            mode = "n";
            key = "<C-l>";
            action = "<C-w>l";
          }

          {
            mode = "i";
            key = "<C-h>";
            action = "<Left>";
          }
          {
            mode = "i";
            key = "<C-j>";
            action = "<Down>";
          }
          {
            mode = "i";
            key = "<C-k>";
            action = "<Up>";
          }
          {
            mode = "i";
            key = "<C-l>";
            action = "<Right>";
          }
          {
            mode = ["n"];
            key = "<ESC>";
            action = "<cmd>noh<CR>";
            noremap = false;
          }
        ];
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
