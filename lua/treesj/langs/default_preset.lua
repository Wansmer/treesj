return {
  ---Use for split and join. Will merge to both resulting presets
  ---If you need various values for different modes,
  ---it can be overridden in modes sections
  ---@type table
  both = {
    ---TreeSJ will stop if node contains node from list
    ---@type string[]
    no_format_with = { 'comment' },
    ---Separator for arrays, objects, hash e.c.t.
    ---Will auto add to option 'omit' for 'both'
    ---@type string
    separator = '',
    ---Set last separator or not
    ---@type boolean
    last_separator = false,
    ---Nodes in list will be joined for previous node.
    ---(e.g. tag_name in HTML start_tag or separator (',') in JS object)
    ---NOTE: Must be same for both modes
    omit = {},
    ---boolean: Non-bracket nodes (e.g., with then end instead of {}|<>|[])
    ---NOTE: Must be same for both modes
    non_bracket_node = false,
    ---If true, empty brackets, empty tags, or node which only contains nodes from 'omit' no will handling
    ---(ignored, when non_bracket_node = true)
    format_empty_node = true,
    ---function|nil function (child: TreeSJ): void
    ---Custom callback for transforming text of children nodes. Can be different for split and join
    foreach = nil,
    ---{ left = string, right = string, pack = string }
    ---@type { [string]: string }|function|nil
    add_framing_nodes = nil,
    ---Set `false` if node should't be splitted or joined. Can be different for both modes
    ---@type boolean|function function (tsnode): boolean
    enable = true,
    filter = nil,
  },
  ---Use only for join. If contains field from 'both',
  ---field here have higher priority
  join = {
    ---Adding space in framing brackets or last/end element
    space_in_brackets = false,
    ---Count of whitespace between nodes
    space_separator = 1,
    ---string: Add instruction separator like ';' in statement block
    ---Will auto add to option 'omit' for 'both'
    force_insert = '',
    ---list[string|function]: The insert symbol will be omitted if node contains in this list
    ---(e.g. function_declaration inside statement_block in JS no require instruction separator (';'))
    no_insert_if = {},
    ---boolean: All nested configured nodes will process according to their presets
    recursive = true,
    ---string: Type of configured node or function(returning boolean) for type of node that must be ignored
    recursive_ignore = {},
  },
  ---Use only for split. If contains field from 'both',
  ---field here have higher priority
  split = {
    ---boolean: All nested configured nodes will process according to their presets
    recursive = false,
    ---string: Type of configured node or function(returning boolean) for type of node that must be ignored
    recursive_ignore = {},
    ---string: Which indent must be on the last line of the formatted node.
    ---'normal' – indent equals of the indent from first line;
    ---'inner' – indent, like all inner nodes (indent of start line of node + vim.fn.shiftwidth()).
    last_indent = 'normal',
    ---string: Which indent must be on the last line of the formatted node.
    ---'normal' – indent equals of the indent from first line;
    ---'inner' – indent, like all inner nodes.
    inner_indent = 'inner',
  },
  ---If 'true', node will be completely removed from langs preset
  disable = false,
  ---TreeSJ will search child from list into this node and redirect to found child
  ---If list not empty, another fields (split, join) will be ignored
  target_nodes = {},
}
