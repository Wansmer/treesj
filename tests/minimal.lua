-- Based on https://github.com/folke/lazy.nvim/blob/3bde7b5ba8b99941b314a75d8650a0a6c8552144/tests/init.lua

local CWD = vim.loop.cwd() .. '/'

vim.opt.shiftwidth = 2
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.shadafile = 'NONE'
vim.opt.expandtab = true

vim.cmd([[set runtimepath=$VIMRUNTIME]])
vim.opt.runtimepath:append(CWD)
vim.opt.packpath = { CWD .. '.tests/site' }

local dependencies = {
  'nvim-lua/plenary.nvim',
  'nvim-treesitter/nvim-treesitter',
}

local function install_dep(plugin)
  local name = plugin:match('.*/(.*)')
  local package_root = CWD .. '.tests/site/pack/deps/start/'
  if not vim.loop.fs_stat(package_root .. name) then
    vim.fn.mkdir(package_root, 'p')
    vim.fn.system({
      'git',
      'clone',
      '--depth=1',
      'https://github.com/' .. plugin .. '.git',
      package_root .. '/' .. name,
    })
  end
end

for _, plugin in ipairs(dependencies) do
  install_dep(plugin)
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if vim.bo.filetype == 'go' then
      vim.bo.expandtab = false
    end
  end,
})

require('plenary.busted')
require('nvim-treesitter.configs').setup({
  ensure_installed = require('treesj.langs').configured_langs,
  sync_install = true,
})
