{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    enableManpages = true;
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
            mode = ["n"];
            key = "<S-l>";
            action = "<cmd>BufferLineCycleNext<CR>";
          }
          {
            mode = ["n"];
            key = "<S-h>";
            action = "<cmd>BufferLineCyclePrev<CR>";
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
}
