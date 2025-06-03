call plug#begin()

" List your plugins here
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " (optional, for icons)

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

EOF

nnoremap <Space>e :NvimTreeToggle<CR>
