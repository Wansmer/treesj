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
    -- string[]: Nodes  in list will be joined for previous node
    -- (e.g. tag_name in HTML start_tag or separator (',') in JS object)
    -- NOTE: Must be same for both modes
    omit = {},
  },
  -- Use only for join. If contains field from 'both',
  -- field here have higher priority
  join = {
    -- Adding space in framing brackets or last/end element
    space_in_brackets = false,
    -- Count of whitespace between nodes
    space_separator = 1,
    -- string: Add instruction separator like ';' in statement block
    -- Will auto add to option 'omit' for 'both'
    force_insert = '',
    -- string[]: The insert symbol will be omitted if node contains in this list
    -- (e.g. function_declaration inside statement_block in JS no require instruction separator (';'))
    no_insert_if = {},
    -- boolean: All nested configured nodes will process according to their presets
    recursive = true,
    -- [string|function]: Type of configured node or function(returning boolean) for type of node that must be ignored
    recursive_ignore = {},
  },
  -- Use only for split. If contains field from 'both',
  -- field here have higher priority
  split = {
    -- boolean: All nested configured nodes will process according to their presets
    recursive = false,
    -- [string|function]: Type of configured node or function(returning boolean) for type of node that must be ignored
    recursive_ignore = {},
  },
  -- If 'true', node will be completely removed from langs preset
  disable = false,
  -- TreeSJ will search child from list into this node and redirect to found child
  -- If list not empty, another fields (split, join) will be ignored
  target_nodes = {},
}
