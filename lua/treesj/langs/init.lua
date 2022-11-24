local langs = {
  'javascript',
  'typescript',
  'lua',
  'html',
  'json',
  'vue',
  'css',
  'scss',
  'tsx',
  'jsx',
}

local M = {}

M.presets = {}

for _, lang in ipairs(langs) do
  M.presets[lang] = require('treesj.langs.' .. lang)
end

return M
