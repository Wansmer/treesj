# TreeSJ: split or join blocks of code

Neovim plugin for splitting/joining blocks of code like arrays, hashes, statements, objects, dictionaries, etc. Written in Lua, using [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/).

Inspired by and partly repeats the functionality of [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim).

> *⚡Disclaimer: The plugin is under active development. Documentation will be added when all planned features are implemented. Feel free to open an issue or PR 💪*

<https://user-images.githubusercontent.com/46977173/201088511-b336cec5-cec4-437f-95b3-0208c83377fd.mov>

<sup align="center">Theme: [Catppuccin](https://github.com/catppuccin/nvim), Font: JetBrains Mono</sup>

## Features

- **Can be called from anywhere in the block**: No need to move cursor to specified place to split/join block of code;
- **Make cursor sticky**: The cursor follows the text on which it was called;
- **Autodetect mode**: Toggle-mode present. Split or join blocks by same key mapping;
- **Do it recursively**: Expand or collapse all nested nodes? Yes, you can;
- **Recognize nested languages**: Filetype doesn't matter, detect language with treesitter.

## Requirements

1. [Neovim 0.8+](https://github.com/neovim/neovim/releases)
2. [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Installation

With [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use({
  'Wansmer/treesj',
  requires = { 'nvim-treesitter' },
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
})
```

## Configuration

### Plugin configuration

Default configuration:

```lua
local tsj = require('treesj')

local langs = {--[[ configuration for languages ]]}

tsj.setup({
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 120,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,
  langs = langs,
})
```

Also, TreeSJ provide user commands:

1. `:TSJToggle` - toggle node under cursor (split if one-line and join if multiline);
2. `:TSJSplit` - split node under cursor;
3. `:TSJJoin` - split node under cursor;

### Languages configuration

By default, TreeSJ has presets for these languages:

- **Javascript**;
- **Typescript**;
- **Tsx**;
- **Jsx**;
- **Lua**;
- **CSS**;
- **SCSS**;
- **HTML**;
- **Vue**;
- **JSON**;
- **PHP**;
- **Ruby**;
- **Go**;
- **Java**;

For adding your favorite language, add it to `langs` sections in your configuration. Also, see how [to implement fallback](https://github.com/Wansmer/treesj/discussions/19) to splitjoin.vim.

To find out what nodes are called in your language, analyze your code with [nvim-treesitter/playground](https://github.com/nvim-treesitter/playground) or look in the [source code of the parsers](https://tree-sitter.github.io/tree-sitter/).

**Example:**

```lua
local langs = {
  javascript = {
    array = {--[[ preset ]]},
    object = {--[[ preset ]]}
    ['function'] = { target_nodes = {--[[ targets ]]}}
  },
}
```

If you have completely configured your language, and it works as well as you expected, feel free to open PR and share it. (Please, read [manual](/tests/README.md) before PR)

### Nodes configuration

Default preset for node:

```lua
local somenode = {
  -- Use for split and join. Will merge to both resulting presets
  -- If you need various values for different modes,
  -- it can be overridden in modes sections
  both = {
    -- string[]: TreeSJ will stop if node contains node from list
    no_format_with = { 'comment' },

    -- string: Separator for arrays, objects, hash e.c.t.
    -- Will auto add to option 'omit' for 'both'
    separator = '',

    -- boolean: Set last separator or not
    last_separator = false,

    -- list[string|function]: Nodes in list will be joined for previous node
    -- (e.g. tag_name in HTML start_tag or separator (',') in JS object) 
    -- NOTE: Must be same for both modes
    omit = {},
    -- boolean: Non-bracket nodes (e.g., with 'then|()' ... 'end' instead of { ... }|< ... >|[ ... ])
    -- NOTE: Must be same for both modes
    non_bracket_node = false,
    -- If true, empty brackets, empty tags, or node which only contains nodes from 'omit' no will handling
    -- (ignored, when non_bracket_node = true)
    format_empty_node = true,
  },

  -- Use only for join. If contains field from 'both',
  -- field here have higher priority
  join = {

    -- Adding space in framing brackets or last/end element
    space_in_brackets = false,

    -- Count of spaces between nodes
    space_separator = 1,

    -- string: Add instruction separator like ';' in statement block
    -- Will auto add to option 'omit' for 'both'
    force_insert = '',

    -- list[string|function]: The insert symbol will be omitted if node contains in this list 
    -- (e.g. function_declaration inside statement_block in JS no require instruction separator (';'))
    no_insert_if = {},

    -- boolean: All nested configured nodes will process according to their presets
    recursive = true,

    -- [string]: Type of configured node that must be ignored 
    recursive_ignore = {},
  },

  -- Use only for split. If contains field from 'both',
  -- field here have higher priority
  split = {
    -- boolean: All nested configured nodes will process according to their presets
    recursive = false,

    -- [string]: Type of configured node that must be ignored 
    -- E.g., you probably don't want the parameters of each nested function to be expanded.
    recursive_ignore = {},

    -- string: Which indent must be on the last line of the formatted node.
    -- 'normal' – indent equals of the indent from first line;
    -- 'inner' – indent, like all inner nodes.
    last_indent = 'normal',
  },
  -- If 'true', node will be completely removed from langs preset
  disable = false,

  -- TreeSJ will search child from list into this node and redirect to found child
  -- If list not empty, another fields (split, join) will be ignored
  target_nodes = {},
}
```

All nodes in every language have similar characteristics.
TreeSJ provide default presets for common nodes:

`set_default_preset(override)` - default.

`set_preset_for_list(override)` - list-like nodes.

`set_preset_for_dict(override)` - dict-like nodes.

`set_preset_for_statement(override)` - statement-like nodes.

`set_preset_for_args(override)` - arguments-like nodes.

`set_preset_for_non_bracket(override)` - non-bracket nodes;

Takes a table with the settings to be overwritten as an argument.

**Usage example**:

```lua
local tsj_utils = require('treesj.langs.utils')

local langs = {
  javascript = {
    object = tsj_utils.set_preset_for_dict(),
    array = tsj_utils.set_preset_for_list(),
    formal_parameters = tsj_utils.set_preset_for_args(),
    arguments = tsj_utils.set_preset_for_args(),
    statement_block = tsj_utils.set_preset_for_statement({
      join = {
        no_insert_if = {
          'function_declaration',
          'try_statement',
          'if_statement',
        },
      },
    }),
  },
  lua = {
    table_constructor = tsj_utils.set_preset_for_dict(),
    arguments = tsj_utils.set_preset_for_args(),
    parameters = tsj_utils.set_preset_for_args(),
  },
}
```

Also, you can use whole preset for language if your language has the same types of nodes:

> For example, `css` and `scss` have the same structure, and you can use already configured preset

```lua
local tsj_utils = require('treesj.langs.utils')
local css = require('treesj.langs.css')

local langs = {
  scss = u.merge_preset(css, {--[[
    Here you can override existing nodes 
    or add language-specific nodes
]]})
} 
```

## How it works

When you run the plugin, TreeSJ detects the node under the cursor, recognizes the language, and looks for it in the presets.
If the current node is not configured, TreeSJ checks the parent node, and so on, until a configured node is found.

Presets for node can be two types:

1. With preset for self           - if this type is found, the node will be formatted;
2. With referens for nested nodes - in this case, search will be continued among this node descendants;

**Example**:

> "|" - meaning cursor

```javascript
const arr = [ 1, 2, 3 ]
```

```txt
// with preset for self
const arr = [ 1, |2, 3 ];
                 |      
    first node is 'number' - not configured,
    parent node is 'array' - configured and will be split

// with referens
cons|t arr = [ 1, 2, 3 ];
    |      
  first node is 'variable_declarator' - not configured,
  parent node is 'lexical_declaration' - configured and has reference
  { target_nodes = { 'array', 'object' } },
  first configured nested node is 'array' and array will be splitted
```
