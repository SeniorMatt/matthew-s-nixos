-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("catppuccin").load "mocha"
require("lazy").load({ plugins = { "mason.nvim" } })
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c_sharp",  -- <-- this line ensures C# highlighting
    -- other languages...
  },
  highlight = {
    enable = true,
  },
})
require("lspconfig").omnisharp.setup({
  cmd = { "omnisharp" }, -- or full path if needed
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
})

