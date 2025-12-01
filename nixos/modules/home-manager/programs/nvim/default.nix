{ inputs, pkgs, user, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  home.packages = with pkgs; [
    neovim-remote
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };

  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        options.clipboard = "unnamedplus";
        clipboard = {
          providers = {
            wl-copy.enable = true;
          };
        };
        startPlugins = [ null ];
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
          vim.opt.colorcolumn = "80"
        '';

        spellcheck = {
          enable = false;
        };

        lsp = {
          enable = true;
          formatOnSave = false;
          lspkind.enable = true;
          lspconfig.enable = true;
          lspSignature.enable = true;
          mappings.format = "<C-F>";
        };

        languages = {
          enableFormat = false;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;

          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;

          csharp = {
            enable = true;
            lsp = {
              enable = true;
              servers = [ "omnisharp" ];
            };
            treesitter.enable = true;
          };
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = true;
        };

        statusline.lualine.enable = true;

        theme = {
          enable = true;

          # Catppuccin theme
          name = "catppuccin";
          style = "mocha";

          # Onedark theme
          # name = "onedark";
          # style = "dark";
          # transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete = {
          nvim-cmp = {
            enable = true;
            sources = {
              nvim-lsp = "nvim_lsp";
              async-path = "async_path";
            };
          };
        };

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
            cycleNext = "<S-l>";
            cyclePrevious = "<S-h>";
            moveNext = "<A-L>";
            movePrevious = "<A-H>";
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
          git-conflict.enable = true;
        };

        utility = {
          diffview-nvim.enable = true;
          ccc.enable = true;
        };

        notes = {
          obsidian = {
            enable = false;
            setupOpts = {
              workspaces = [
                {
                  name = "personal";
                  path = "/home/${user}/Documents/Obsidian Vault";
                }
              ];
            };
          };
          todo-comments.enable = true;
        };

        ui = {
          fastaction.enable = true;
        };

        comments = {
          comment-nvim.enable = true;
        };

        keymaps = [
          {
            mode = [
              "n"
              "v"
              "i"
            ];
            key = "<C-n>";
            action = "<cmd>Neotree toggle left<CR>";
          }
          {
            mode = [ "n" ];
            key = "<M-r>";
            action = "<cmd>:lua vim.lsp.buf.rename()<CR>";
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
            mode = [ "n" ];
            key = "<ESC>";
            action = "<cmd>noh<CR>";
            noremap = false;
          }
        ];
      };
    };
  };
}
