local M = {}

M.configured_langs = {
  'javascript',
  'typescript',
  'lua',
  'html',
  'json',
  'jsonc',
  'json5',
  'vue',
  'css',
  'scss',
  'tsx',
  'perl',
  'php',
  'php_only',
  'ruby',
  'go',
  'java',
  'pug',
  'svelte',
  'rust',
  'python',
  'starlark',
  'r',
  'cpp',
  'c',
  'toml',
  'yaml',
  'nix',
  'kotlin',
  'bash',
  'sql',
  'dart',
  'elixir',
  'haskell',
  'zig',
  'julia',
  'c_sharp',
}

M.presets = {}

for _, lang in ipairs(M.configured_langs) do
  M.presets[lang] = require('treesj.langs.' .. lang)
end

return M
