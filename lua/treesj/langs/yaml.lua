local lang_utils = require('treesj.langs.utils')

return {
  flow_sequence = {
    join = { enable = false },
    split = {
      non_bracket_node = true,
      last_separator = false,
      last_indent = 'inner',
      no_insert_if = { lang_utils.no_insert.if_penultimate },
      format_tree = function(tsj)
        tsj:remove_child({ ',', '[', ']' })
        for _, flow_node in ipairs(tsj:children({ 'flow_node' })) do
          flow_node:update_text('- ' .. flow_node:text())
        end
        tsj:remove_child(-1)
      end,
    },
  },
  flow_mapping = {
    join = { enable = false },
    split = {
      non_bracket_node = true,
      recursive = true,
      last_indent = 'inner',
      format_tree = function(tsj)
        tsj:remove_child({ ',', '{', '}' })
        tsj:remove_child(-1)
      end,
    },
  },
  block_sequence = {
    split = { enable = false },
    join = {
      space_in_brackets = true,
      non_bracket_node = { left = ' [', right = ']' },
      force_insert = ',',
      no_insert_if = { lang_utils.no_insert.if_penultimate },
      format_tree = function(tsj)
        local items = tsj:children({ 'block_sequence_item' })
        for _, item in ipairs(items) do
          local text = item:text():gsub('^- ', '')
          item:update_text(text)
        end
      end,
    },
  },
  block_mapping = {
    split = { enable = false },
    join = {
      space_in_brackets = true,
      non_bracket_node = { left = ' {', right = '}' },
      force_insert = ',',
      no_insert_if = { lang_utils.no_insert.if_penultimate },
    },
  },
}
