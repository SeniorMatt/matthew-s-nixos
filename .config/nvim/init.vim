call plug#begin()

" List your plugins here
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " (optional, for icons)

" Completion engine
Plug 'hrsh7th/nvim-cmp'

" LSP source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet support (optional but recommended)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Buffer/path completion (optional)
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" LSP configuration
Plug 'neovim/nvim-lspconfig'

" LSP server installer
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" External tool integration (formatters, linters)
Plug 'nvimtools/none-ls.nvim' " (formerly null-ls)


call plug#end()

lua << EOF

require("nvim-tree").setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "c_sharp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  auto_install = true,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("lspconfig").omnisharp.setup({
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" },
  root_dir = require("lspconfig").util.root_pattern("*.csproj", "*.sln"),
})

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "omnisharp" },
}



EOF

nnoremap <Space>e :NvimTreeToggle<CR>

set number
set relativenumber
set clipboard=unnamedplus

