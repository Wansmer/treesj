# TreeSJ

Neovim plugin for splitting/joining blocks of code like arrays, hashes,
statements, objects, dictionaries, etc.

Written in Lua, using [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/).

Inspired by and partly repeats the functionality of
[splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim).

<!-- panvimdoc-ignore-start -->

https://github.com/Wansmer/treesj/assets/46977173/4277455b-81fd-4e99-9af7-43c77dbf542b

<!--toc:start-->

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Settings](#settings)
- [Commands](#commands)
- [How plugin works](#how-plugin-works)
- [Configuration](#configuration)
  - [Languages](#languages)
  - [Basic node](#basic-node)
  - [Advanced node](#advanced-node)
  - [TreeSJ instance](#treesj-instance)

<!--toc:end-->

<!-- panvimdoc-ignore-end -->

## Features

- **Can be called from anywhere in the block**: No need to move cursor to
  specified place to split/join block of code;
- **Make cursor sticky**: The cursor follows the text on which it was called;
- **Autodetect mode**: Toggle-mode present. Split or join blocks by same key
  mapping;
- **Do it recursively**: Expand or collapse all nested nodes? Yes, you can;
- **Recognize nested languages**: Filetype doesn't matter, detect language with
  treesitter;
- **Repeat formatting with `dot`**: `.` support for each action.
- **Smart**: Different behavior depending on the context.

## Requirements

- [Neovim 0.8+](https://github.com/neovim/neovim/releases)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  'Wansmer/treesj',
  keys = { '<space>m', '<space>j', '<space>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
}
```

With [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use({
  'Wansmer/treesj',
  requires = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
})
```

## Settings

Default configuration:

```lua
local tsj = require('treesj')

local langs = {--[[ configuration for languages ]]}

tsj.setup({
  ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = true,
  ---@type boolean Node with syntax error will not be formatted
  check_syntax_error = true,
  ---If line after join will be longer than max value,
  ---@type number If line after join will be longer than max value, node will not be formatted
  max_join_length = 120,
  ---Cursor behavior:
  ---hold - cursor follows the node/place on which it was called
  ---start - cursor jumps to the first symbol of the node being formatted
  ---end - cursor jumps to the last symbol of the node being formatted
  ---@type 'hold'|'start'|'end'
  cursor_behavior = 'hold',
  ---@type boolean Notify about possible problems or not
  notify = true,
  ---@type table Presets for languages
  langs = lu._prepare_presets(langs.presets),
  ---@type boolean Use `dot` for repeat action
  dot_repeat = true,
  ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
  on_error = nil,
})
```

## Commands

TreeSJ provide user commands:

- `:TSJToggle` - toggle node under cursor (split if one-line and join if
  multiline);
- `:TSJSplit` - split node under cursor;
- `:TSJJoin` - join node under cursor;

Similar with lua:

```bash
:lua require('treesj').toggle()
:lua require('treesj').split()
:lua require('treesj').join()
```

In the lua version, you can optionally pass a preset that will overwrite the
default preset values. It should contain `split` or `join` keys. Key `both`
will be ignored.

**Warning**: If you are passing a preset, repeating with a dot will not work.

E.g.:

```lua
-- For use default preset and it work with dot
vim.keymap.set('n', '<leader>m', require('treesj').toggle)
-- For extending default preset with `recursive = true`, but this doesn't work with dot
vim.keymap.set('n', '<leader>M', function()
    require('treesj').toggle({ split = { recursive = true } })
end)
```

## How plugin works

When you run the plugin, TreeSJ detects the node under the cursor, recognizes
the language, and looks for it in the presets. If the current node is not
configured, TreeSJ checks the parent node, and so on, until a configured node is
found.

Presets for node can be two types:

- With preset for self - if this type is found, the node will be formatted;
- With referens for nested nodes or fields - in this case, search will be
  continued among this node descendants;

**Example**:

> "|" - meaning cursor

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

# Configuration

## Languages

By default, TreeSJ has presets for these languages:

- **Javascript**;
- **Typescript**;
- **Tsx**;
- **Jsx**;
- **Lua**;
- **CSS**;
- **SCSS**;
- **HTML**;
- **Pug**;
- **Vue**;
- **Svelte**;
- **JSON**;
- **JSONC**;
- **JSON5**;
- **Toml**;
- **Yaml**;
- **Perl**;
- **PHP**;
- **Ruby**;
- **Python**;
- **Starlark**;
- **Go**;
- **Java**;
- **Rust**;
- **R**;
- **C/C++**;
- **Nix**;
- **Kotlin**;
- **Bash**;
- **SQL**;
- **Dart**;

For adding your favorite language, add it to `langs` sections in your
configuration. Also, see how [to implement
fallback](https://github.com/Wansmer/treesj/discussions/19) to splitjoin.vim.

It is also possible to configure fallback for any node (see [Advanced
node](#advanced-node)).

To find out what nodes are called in your language, analyze your code with
[nvim-treesitter/playground](https://github.com/nvim-treesitter/playground) or
look in the [source code of the
parsers](https://tree-sitter.github.io/tree-sitter/).

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

If you have completely configured your language, and it works as well as you
expected, feel free to open PR and share it.
(Please, read [manual](/tests/README.md) before PR)

## Basic node

Default preset for node:

```lua
local node_type = {
  -- `both` will be merged with both presets from `split` and `join` modes tables.
  -- If you need different values for different modes, they can be overridden
  -- in mode tables unless otherwise noted.
  both = {
    ---If a node contains descendants with a type from the list, it will not be formatted
    ---@type string[]
    no_format_with = { 'comment' },
    ---Separator for arrays, objects, hash e.c.t. (usually ',')
    ---@type string
    separator = '',
    ---Set last separator or not
    ---@type boolean
    last_separator = false,
    ---If true, empty brackets, empty tags, or node which only contains nodes from 'omit' no will handling
    ---@type boolean
    format_empty_node = true,
    ---All nested configured nodes will process according to their presets
    ---@type boolean
    recursive = true,
    ---Type of configured node that must be ignored
    ---@type string[]
    recursive_ignore = {},

    --[[ Working with the options below is explained in detail in `advanced node configuration` section. ]]
    ---Set `false` if node should't be splitted or joined.
    ---@type boolean|function For function: function(tsnode: TSNode): boolean
    enable = true,
    ---@type function|nil function(tsj: TreeSJ): void
    format_tree = nil,
    ---@type function|nil function(lines: string[], tsn?: TSNode): string[]
    format_resulted_lines = nil,
    ---Passes control to an external script and terminates treesj execution.
    ---@type function|nil function(node: TSNode): void
    fallback = nil,

    --[[ The options below should be the same for both modes. ]]
    ---The text of the node will be merged with the previous one, without wrapping to a new line
    ---@type table List-like table with types 'string' (type of node) or 'function' (function(child: TreeSJ): boolean).
    omit = {},
    ---Non-bracket nodes (e.g., with 'then|()' ... 'end' instead of { ... }|< ... >|[ ... ])
    ---If value is table, should be contains follow keys: { left = 'text', right = 'text' }. Empty string uses by default
    ---@type boolean|table
    non_bracket_node = false,
    ---If you need to process only nodes in the range from / to.
    ---If `shrink_node` is present, `non_bracket_node` will be ignored
    ---Learn more in advanced node configuration
    ---@type table|nil
    shrink_node = nil,
    -- shrink_node = { from = string, to = string },
  },
  -- Use only for join. If contains field from 'both',
  -- field here have higher priority
  join = {
    ---Adding space in framing brackets or last/end element
    ---@type boolean
    space_in_brackets = false,
    ---Insert space between nodes or not
    ---@type boolean
    space_separator = true,
    ---Adds instruction separator like ';' in statement block.
    ---It's not the same as `separator`: `separator` is a separate node, `force_insert` is a last symbol of code instruction.
    ---@type string
    force_insert = '',
    ---The `force_insert` symbol will be omitted if the type of node contains in this list
    -- (e.g. function_declaration inside statement_block in JS no require instruction separator (';'))
    ---@type table List-like table with types 'string' (type of node) or 'function' (function(child: TreeSJ): boolean).
    no_insert_if = {},
  },
  -- Use only for split. If contains field from 'both',
  -- field here have higher priority
  split = {
    ---All nested configured nodes will process according to their presets
    ---@type boolean
    recursive = false,
    ---Which indent must be on the last line of the formatted node.
    --- 'normal' – indent equals of the indent from first line;
    --- 'inner' – indent, like all inner nodes (indent of start line of node + vim.fn.shiftwidth()).
    ---@type 'normal'|'inner'
    last_indent = 'normal',
    ---Which indent must be on the last line of the formatted node.
    --- 'normal' – indent equals of the indent from first line;
    --- 'inner' – indent, like all inner nodes (indent of start line of node + vim.fn.shiftwidth()).
    ---@type 'normal'|'inner'
    inner_indent = 'inner',
  },
  ---If 'true', node will be completely removed from langs preset
  ---@type boolean
  disable = false,
  ---TreeSJ will search child from list into this node and redirect to found child
  ---If list not empty, another fields (split, join) will be ignored
  ---@type string[]|table See `advanced node configuration`
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
local lang_utils = require('treesj.langs.utils')

local langs = {
  javascript = {
    object = lang_utils.set_preset_for_dict(),
    array = lang_utils.set_preset_for_list(),
    formal_parameters = lang_utils.set_preset_for_args(),
    arguments = lang_utils.set_preset_for_args(),
    statement_block = lang_utils.set_preset_for_statement({
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
    table_constructor = lang_utils.set_preset_for_dict(),
    arguments = lang_utils.set_preset_for_args(),
    parameters = lang_utils.set_preset_for_args(),
  },
}
```

Also, you can use whole preset for language if your language has the same types
of nodes:

> For example, `css` and `scss` have the same structure, and you can use already
> configured preset

```lua
local tsj_utils = require('treesj.langs.utils')
local css = require('treesj.langs.css')

local langs = {
  scss = tsj_utils.merge_preset(css, {--[[
    Here you can override existing nodes
    or add language-specific nodes
]]})
}
```

## Advanced node

Although most nodes have similar parameters and can be configured declarative,
sometimes you need to change the values, text, or order of children on the fly.

To do this, some options accept functions as a value, which are passed instances
of [TSNode](https://neovim.io/doc/user/treesitter.html#treesitter-node),
[TreeSJ](#treesj-instance), or an array of rows to insert.

#### Option `enable`

The `enable` option can be a boolean value or a function. The function takes the
found [TSNode](https://neovim.io/doc/user/treesitter.html#treesitter-node) node
as arguments and should return a boolean value.

<details>
<summary>Example of usage</summary>

The problem:

```go
// from 'import_spec_list'
import (
    "123"
)

// to 'import_spec' and back
import "123"

// but disable 'import_spec_list' when two or more 'import_spec' inside and
// disable 'import_spec' when it already inside 'import_spec_list'
import (
    "123"
    "321"
)
```

This can be implemented with:

```lua
local go = {
  import_spec = lang_utils.set_preset_for_args({
    both = {
      -- If the parent is a 'import_spec_list', then skip this node and
      -- look for a suitable one for formatting further
      enable = function(tsn)
        return tsn:parent():type() ~= 'import_spec_list'
      end,
    },
    split = {
      -- If the parent was something else, then wrap the import in parentheses,
      -- which actually converts the 'import_spec' into the 'import_spec_list'
      format_tree = function(tsj)
        tsj:wrap({ left = '(', right = ')' })
      end,
    },
  }),
  import_spec_list = lang_utils.set_preset_for_args({
    join = {
      enable = function(tsn)
        -- If the node contains more than one named child node, then disable
        return tsn:named_child_count() < 2
      end,
      format_tree = function(tsj)
        -- If there was only one named element, then remove the brackets
        tsj:remove_child({ '(', ')' })
      end,
    },
  }),
}
```

</details>

#### Option `fallback`

The `fallback` option passes control to a third-party script that can be called
within the function. When this option is used, `treesj` only searches for the
required node, but does not process it.

A found TSNode instance is passed to the function, which can be handled
independently. For example, you can get the region of its location, check its
siblings, etc.

<details>
<summary>Example of usage</summary>

The problem:

This action is difficult to implement with `treesj`, so you can pass control to
`splitjoin.vim` if the found node is a `class` or `module`.

> Note that in the above example, `splitjoin.vim' requires the cursor to be on the
> name of a class or module. In some cases, you may need to keep track of the
> position of the cursor from which the handler is called.

```ruby
# RESULT OF JOIN
class Foo::Bar::Baz < Quux
  def initialize
    # foo
  end
end

# RESULT OF SPLIT
module Foo
  module Bar
    class Baz < Quux
      def initialize
        # foo
      end
    end
  end
end
```

This can be implemented with:

```lua
ruby = {
  module = {
    both = {
      no_format_with = {}, -- Need to avoid 'no format with comment'
      fallback = function(_)
        vim.cmd('SplitjoinJoin')
      end,
    },
  },
  class = {
    both = {
      no_format_with = {},
      fallback = function(_)
        vim.cmd('SplitjoinSplit')
      end,
    },
  },
},
```

</details>

#### Option `no_insert_if`

The `preset[join].no_insert_if` option takes an array with node types or
functions. The function takes a TreeSJ as a parameter (each child of the root
node in turn) and should return a boolean if that child matches the condition.

The utilities have helper functions that you will need most often:

`lang_utils.helpers.if_penultimate`

`lang_utils.helpers.if_second`

`lang_utils.helpers.by_index(index)`

`lang_utils.helpers.has_parent(parent_type)`

`lang_utils.helpers.match(pattern)`

`lang_utils.helpers.contains(tsn_types)`

<details>

<summary>Example of usage</summary>

The problem:

```kotlin
// Kotlin's 'statements' should be separated with ';' after each child
// when it joins, but for the last named child it is not necessary,
// and we want to skip it

// from
call_expression("arg1") {
  call1(1, 2)
  call2(1, 2)
}

// to                                             | here no ';', great
call_expression("arg1") { call1(1, 2); call2(1, 2) }
```

This can be implemented with:

```lua
local lang_utils = require('treesj.langs.utils')

local kotlin = {
  statements = lang_utils.set_preset_for_non_bracket({
    join = {
      force_insert = ';',
      no_insert_if = {
        lang_utils.no_insert.if_penultimate,
      },
    },
  }),
}
```

</details>

#### Option `omit`

The `preset[both]omit` option accepts a list of node types or functions. If at
the time the tree is built, the type of the child matches one of the listed
ones, then this child remains unchanged. (does not wrap to a new line in case of
a split, or its position and spaces do not change in the case of a join).

When some value of list is `function` the principle of operation is the same as
that of `no_insert_if`.

#### Option `non_bracket_node`

Some languages have nodes that can be split and joined, but they don't have
brackets or other framing elements.

In this case, it is necessary not only to simulate the framing nodes, but also
to calculate a new range for inserting rows.

`preset[both].non_bracket_node` can be a boolean value (in which case wrapping
node imitators are created with an empty value) or take a table that
specifies what text should wrap the actual base node.

E.g., table value: `{ left = 'text', right = 'text' }`

<details>

<summary>Example of usage</summary>

The problem:

```lua
-- `block` in Lua does not have parentheses, but when it joins,
-- it must jump up a line and pull an `end` node that is not part of it.
-- To do this, you need to create imitators of framing nodes one line above
-- and one line below
               | -- imitator left-side bracket
function test()|
  | -- real start of `block`
  |print(123)
  return 123| -- real end of `block`
| -- imitator right-side bracket
|end

-- from
function test()
  print(123)
  return 123
end

-- to and back
function test() print(123) return 123 end
```

This can be implemented with:

```lua
local lang_utils = require('treesj.langs.utils')

local lua = {
  block = {
    both = {
      non_bracket_node = true,
      -- non_bracket_node = { left = '', right = '' }, - it is similar
    },
    join = {
      space_in_brackets = true,
    },
  },
}
```

</details>

#### Option `shrink_node`

The `shrink_node` option does not process or modify text outside the specified
child types in from/to. This is needed when the node does not have a container,
but can be split or join. For better understanding, see example of usage.

<details>

<summary>Example of usage</summary>

The problem:

In the Kotlin language, the `function_declaration` node has parameters in
brackets, but they are not packaged in a separate container and go at the same
level as the other children of the `function_declaration`.

The difficulty is that the last element in `function_declaration` is
`function_body`, which must remain unchanged and can be multi-line.

```kotlin
| - start of `function_declaration`
|        | - from             | - to
|        |                    | | - `function_body` must remain unchanged
|fun test(a: String, b: String) {
         | - start insert range
                              | - end insert range
         Everything outside the insertion range will remain unchanged,
         even though it is part of the node
  val var1 = 1
  val var2 = 2
}|
 | - end of `function_declaration`

// from
fun test(a: String, b: String) {
  val var1 = 1
  val var2 = 2
}
// to
fun test(
  a: String,
  b: String
) {
  val var1 = 1
  val var2 = 2
}
```

This can be implemented with:

```lua
{
  function_declaration = lang_utils.set_preset_for_args({
    both = {
      non_bracket_node = true,
      shrink_node = { from = '(', to = ')' },
    },
  }),
}
```

</details>

#### Option `target_nodes`

In most cases, `target_nodes` is a list of node types to redirect the search for
the configured node deeper. But in reality it is treated like a dictionary:

```lua
-- these values are equivalent
target_nodes = { 'block', 'statement' }
target_nodes = { ['block'] = 'block', ['statement'] = 'statement' }
```

The key must be a node type or a field name. The value is the name of any
configured node whose preset is to be used.

If the field name is specified in the keys, then it has the highest priority
over node types.

This also means that you can redirect found fields or nodes for processing with
other (including custom) presets.

```lua
{
  block = lang_utils.set_preset_for_statement(),
  my_custom_preset_for_block_inside_fun_dec = {--[[ another preset ]]}
  function_declaration = {
      target_nodes = { ['block'] = 'my_custom_preset_for_block_inside_fun_dec' }
  }
}
```

<details>

<summary>Example of usage</summary>

The problem:

```rust
match x {
    //   | - it is a field `value` and now it `integer_literal`
    _ => 12
    //   `integer_literal` is not configured and can't be configured
    //   but you can transform this field into a `block` node
}

match x {
    _ => {
        12
    }
}

```

This can be implemented with:

```lua
local rust = {
  match_arm = {
    target_nodes = { 'value' },
  },
  value = lang_utils.set_preset_for_statement({
    split = {
      format_tree = function(tsj)
        if tsj:type() ~= 'block' then
          tsj:wrap({ left = '{', right = '}' })
        end
      end,
    },
    join = {
      no_insert_if = { lang_utils.helpers.if_penultimate },
      format_tree = function(tsj)
        local node = tsj:tsnode()
        local parents = { 'match_arm', 'closure_expression' }
        local has_parent = vim.tbl_contains(parents, node:parent():type())
        if has_parent and node:named_child_count() == 1 then
          tsj:remove_child({ '{', '}' })
        end
      end,
    },
  }),
}
```

</details>

#### Option `format_tree`

`format_tree` is a function that takes a TreeSJ root node. In this function, you
can work with the context and add or remove elements.

<details>

<summary>Example of usage</summary>

The problem:

Python's `import_from_statement` does not have a container for a list of imported modules.

Here you need to add parentheses to the middle and end of TreeSJ when splitting and remove these parentheses when joining.

```python
# from
from re import search, match,sub

# to this and back
from re import (
    search,
    match,
    sub,
)
```

This can be implemented with:

```lua
local python = {
  import_from_statement = lang_utils.set_preset_for_args({
    both = {
      -- There is no need to wrap the second element, the 'import' node,
      -- and the first parenthesis, which does not already exist.
      omit = { lang_utils.omit.if_second, 'import', ' (' },
    },
    split = {
      last_separator = true,
      format_tree = function(tsj)
        -- If there are no brackets, then create them
        if not tsj:has_children({ '(', ')' }) then
          tsj:create_child({ text = ' (' }, 4)
          tsj:create_child({ text = ')' }, #tsj:children() + 1)
          -- Since the elements have moved, you need to add the penultimate
          -- separator manually
          local penult = tsj:child(-2)
          penult:update_text(penult:text() .. ',')
        end
      end,
    },
    join = {
      format_tree = function(tsj)
        -- Remove brackets
        tsj:remove_child({ '(', ')' })
      end,
    },
  }),
}
```

</details>

#### Option `format_resulted_lines`

The `format_resulted_lines` function takes as an argument an array of strings
that will replace the content of the base node. The second optional argument is
the node that was processed. Useful if you want to format terms based on some
values, such as a range.

The function should return an array of strings that may have been modified.

If the mode is "join", then after executing this function, these strings will be
concatenated.

E.g.:

```lua
-- base node
local dict = { one = 'one', two = 'two' }

-- array of string for replacement is { "{", "    one = 'one',", "    two = 'two',", "}" }

-- base node after format
local dict = {
    one = 'one',
    two = 'two',
}

```

<details>

<summary>Example of usage</summary>

The problem:

Python's `import_from_statement` does not have a container for a list of
imported modules.

Here you need to add parentheses to the middle and end of TreeSJ when splitting
and remove these parentheses when joining.

```ruby
# from
if cond
    do_that('cond')
else
    do_this('not nond')
end

# to this and back
cond ? do_that('cond') : do_this('not nond')
```

This can be implemented with:

```lua
local ruby = {
  conditional = lang_utils.set_default_preset({
    join = { enable = false },
    split = {
      omit = { lang_utils.omit.if_second },
      format_tree = function(tsj)
        local children = tsj:children()
        table.insert(children, tsj:create_child({ text = 'end', type = 'end' }))
        tsj:child('?'):update_text('if ')
        tsj:child(':'):update_text('else')
        local first, second = tsj:child(1), tsj:child(2)
        children[1] = second
        children[2] = first
        tsj:update_children(children)
      end,
      format_resulted_lines = function(lines)
        return vim.tbl_map(function(line)
          -- Need to remove one indent on `else` element
          if line:match('%s.else$') then
            local rgx = '^' .. (' '):rep(vim.fn.shiftwidth())
            return line:gsub(rgx, '')
          else
            return line
          end
        end, lines)
      end,
    },
  }),
}
```

</details>

## TreeSJ instance

After the node for formatting is found, an instance of the TreeSJ class is
created. Each of its children and descendants is also an instance of this class.
The methods of this class can be used to change formatting behavior on the fly
(see advanced node configuration).

### TreeSJ Lifecycle

- **Checking the found Node**: There is a check that there is no syntax error in
  the node, there are no descendants with types from `preset[mode].no_format_with`
  and `preset[mode].enable` is true.
- **Creating root TreeSJ**: A node for formatting has been found and checked,
  and an instance of TreeSJ is created based on it.
- **Build tree**: It iterates all the children of the base node and creates
  the TreeSJ children. If the `preset[mode].recursive` is true, then a check is made
  to see if the child or its children are configured, if so, a tree is built
  for it and its children.
- **Remove or insert last separator**: if a separator is specified in the
  preset.
- **Run `preset[mode].format_tree`**: custom function from preset.
- **Mode-based preparation**: spacing or indenting, adding a
  `preset.join.force_insert`, forming a list of strings to replace the base node
  content.
- **Run `preset[mode].format_resulted_lines`**: custom function from preset.

### Methods

<details>

<summary>Show/Hide methods...</summary>

#### has_children

Checks if the specified types of children exist among the list of children.
If types are omitted, checks that there is at least one child.

```lua
---@param types? string[]
---@return boolean
function TreeSJ:has_children(types)
```

#### iter_children

Iterate all TreeSJ children.
Use: `... for child, index in tsj:iter_children() do ...`

```lua
---@return function, table
function TreeSJ:iter_children()
```

#### children

Get the children list of the current TreeSJ. Returns all children if `types` are
omitted, otherwise returns all children of the listed types.

```lua
---@param types? string[] List-like table with child's types for filtering
---@return TreeSJ[]
function TreeSJ:children(types)
```

#### root

Get root TreeSJ node of current TreeSJ

```lua
---@return TreeSJ TreeSJ instance
function TreeSJ:root()
```

#### parent

Get parent TreeSJ

```lua
---@return TreeSJ|nil
function TreeSJ:parent()
```

#### child

Get the child of the current node, using its `type` (`tsj:type()`) or `index`.

- The `index` can be a negative value, which means to search from the end of the
  list.
- If a `type` is passed, the first element found will be returned. To get an
  array of similar elements, use `TreeSJ:children(types)`.

```lua
---@param type_or_index number|string Type of TreeSJ child or it index in children list
---@return TreeSJ|nil
function TreeSJ:child(type_or_index)
```

#### create_child

Creating a new TreeSJ instance as a child of current TreeSJ.

- data: {text=string, type=string|nil, copy_from=TreeSJ|nil}
  The "copy_from" field is used if a node needs to be duplicated and expects TreeSJ.
  If a TreeSJ instance is passed to it, then the "text" and "type" fields will be ignored.
- index: If index present, puts it in children list and returned this child,
  if not – returned child, but not puts it in children list. Index can be a negative value,
  meaning insert from the end. If an index is specified that is outside the list of children,
  then `nil` will be returned.

```lua
---@param data table { text = string, type? = string }. If `type` not present, uses value of `text`
---@param index? integer Index where the child should be inserted.
---@return TreeSJ|nil
function TreeSJ:create_child(data, index)
```

#### update_children

Updating children list of current TreeSJ

```lua
---@param children TreeSJ[]
function TreeSJ:update_children(children)
```

This function must be called every time you update the list of children from
outside, for example:

```lua
-- When a function should be called
local children = tsj:children()
local child = tsj:create_child({ text = 'end' })
table.insert(children, child)
tsj:update_children(children) -- important

-- Here it is not necessary
tsj:create_child({ text = 'end' }, #tsj:children() + 1)
```

#### remove_child

Removes children by the passed types or index.

```lua
---@param types_or_index string|string[]|integer Type, types, or index of child to remove
function TreeSJ:remove_child(types_or_index)
```

#### wrap

Creates the first and last elements in the list of children of the current TreeSJ.

- If the `wrap` mode is passed (the default), then a new list of children is
  created with one element as itself, and the wrapping elements are added to it.
- If the `inline` mode is passed, then the real list of children of the current
  TreeSJ is used to add framing elements.

```lua
---@param data table { left = string, right = string }
---@param mode? 'wrap'|'inline' 'wrap' by default
function TreeSJ:wrap(data, mode)
```

#### swap_children

Helps to swap elements by their indexes

```lua
---@param index1 integer
---@param index2 integer
function TreeSJ:swap_children(index1, index2)
```

#### tsnode

Get [TSNode](https://neovim.io/doc/user/treesitter.html#treesitter-node) or
TSNode imitator of current TreeSJ. If you plan to use tsnode methods in the
future, you first need to check that the returned value is not an imitator.

```lua
---@return TSNode|table TSNode or TSNode imitator
function TreeSJ:tsnode()
```

#### prev

Get left side TreeSJ

```lua
---@return TreeSJ|nil
function TreeSJ:prev()
```

#### next

Get right side TreeSJ

```lua
---@return TreeSJ|nil
function TreeSJ:next()
```

#### type

Get node type of current TreeSJ.

```lua
---@return string
function TreeSJ:type()
```

#### text

Get text of current TreeSJ.
At the time of the execution of the `format_tree` function, the text will always
be returned, not the table.

```lua
---@return string|table
function TreeSJ:text()
```

#### update_text

Updating text of current TreeSJ. If the mode "split" and "recursively" is
active, then it can be an array. In such a case, you need to update the text in
its children directly.

```lua
---@param new_text string|string[]
function TreeSJ:update_text(new_text)
```

When working in recursive mode, you need to check that the nodes in which you
want to change the text do not have children for recursive processing. In this
case, the text will be glued from the children of the node, and you need to
change the text in them.

E.g.:

```lua
{
  format_tree = function(tsj)
    if tsj:type() ~= 'statement_block' then
      -- ...
      local body = tsj:child(2)
      if body:will_be_formatted() then
        local set_return
        if body:has_preset('split') then
          set_return = body:child(1)
        else
          set_return = body:child(1):child(1)
        end
        set_return:update_text('return ' .. set_return:text())
      else
        body:update_text('return ' .. body:text())
      end
      -- ...
    end
  end,
}
```

#### will_be_formatted

Returns true if the current TreeSJ will be formatted.
The conditions are met: recursion is active, the current element has a preset, or among its descendants there are nodes that will be processed.

```lua
---@return boolean
function TreeSJ:will_be_formatted()
```

#### is_ignore

Checks if the current TreeSJ child must be ignored while recursive formatting.

```lua
---@return boolean
function TreeSJ:is_ignore()
```

#### has_to_format

Checks if the TreeSJ contains children that need to be formatted

```lua
---@return boolean
function TreeSJ:has_to_format()
```

#### is_first

Checks if the current node is first among sibling

```lua
---@return boolean
function TreeSJ:is_first()
```

#### is_last

Checks if the current node is last among sibling

```lua
---@return boolean
function TreeSJ:is_last()
```

#### is_framing

Checks if the current node is first or is last among sibling

```lua
---@return boolean
function TreeSJ:is_framing()
```

#### is_omit

Checks if the text of current TreeSJ's type contains at `preset[mode].omit`

```lua
---@return boolean
function TreeSJ:is_omit()
```

#### is_imitator

Checks if the current TreeSJ is node-imitator

```lua
---@return boolean
function TreeSJ:is_imitator()
```

#### preset

Get preset for current TreeSJ

```lua
---@param mode? 'split'|'join' Current mode (split|join)
---@return table|nil
function TreeSJ:preset(mode)
```

#### parent_preset

Get the preset of the TreeSJ parent

```lua
---@param mode? 'split'|'join' Current mode (split|join)
---@return table|nil
function TreeSJ:parent_preset(mode)
```

#### update_preset

Updates the presets for the current TreeSJ.

```lua
---@param new_preset table
---@param mode? 'split'|'join'
function TreeSJ:update_preset(new_preset, mode)
```

</details>
