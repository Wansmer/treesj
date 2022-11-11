set rtp +=.
set rtp +=../plenary.nvim/
set rtp +=../nvim-treesitter

runtime! plugin/plenary.vim
runtime! plugin/nvim-treesitter.vim

set noswapfile
set nobackup

filetype indent off
set nowritebackup
set noautoindent
set nocindent
set nosmartindent
set indentexpr=

set shiftwidth=2

lua << EOF
require('plenary/busted')
local ts = require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
})
EOF
