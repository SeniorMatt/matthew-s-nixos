call plug#begin()

" List your plugins here
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " (optional, for icons)

call plug#end()

lua << EOF
require("nvim-tree").setup()
EOF

nnoremap <Space>e :NvimTreeToggle<CR>
