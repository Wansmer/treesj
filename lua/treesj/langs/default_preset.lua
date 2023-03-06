return {
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
    -- function|nil function (child: TreeSJ): void
    -- Custom callback for transforming text of children nodes. Can be different for split and join
    foreach = nil,
    -- nil|table { left = string, right = string }
    -- Adding first and last custom nodes, e.g., [], {}, e.t.c, if needed (e.g., see YAML)
    add_framing_nodes = nil,
    -- boolean|function function (tsnode): boolean
    -- Set `false` if node should't be splitted or joined. Can be different for both modes
    enable = true,
    -- table|nil
    -- See 'Lifecycle' section
    lifecycle = nil,
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
    -- 'inner' – indent, like all inner nodes (indent of start line of node + vim.fn.shiftwidth()).
    last_indent = 'normal',
    -- string: Which indent must be on the last line of the formatted node.
    -- 'normal' – indent equals of the indent from first line;
    -- 'inner' – indent, like all inner nodes (indent of start line of node + vim.fn.shiftwidth()).
    inner_indent = 'inner',
  },
  -- If 'true', node will be completely removed from langs preset
  disable = false,
  -- TreeSJ will search child from list into this node and redirect to found child
  -- If list not empty, another fields (split, join) will be ignored
  target_nodes = {},
}
