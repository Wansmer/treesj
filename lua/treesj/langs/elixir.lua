local lang_utils = require('treesj.langs.utils')

return {
  list = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false,
    },
    split = {
      recursive = false,
      last_separator = false,
    },
  }),
  map = { target_nodes = { 'map_content' } },
  map_content = lang_utils.set_preset_for_list({
    both = {
      non_bracket_node = true,
    },
    split = {
      last_separator = false,
      format_tree = function(tsj)
        if tsj:has_children({ 'keywords' }) then
          tsj:update_preset(
            { recursive = true, recursive_ignore = { 'map' } },
            'split'
          )
          local keywords = tsj:child('keywords')
          keywords:update_preset({ inner_indent = 'normal' }, 'split')
        end
      end,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  keywords = lang_utils.set_preset_for_list({
    both = {
      non_bracket_node = true,
      -- This is only needed because for some reason join and
      -- split on a keyword where the value is a map goes like this:
      -- expected: 'key: %{ a: "b" }'
      -- result: 'key:%{ a: "b" }'
      format_tree = function(tsj)
        if tsj:has_children({ 'pair' }) then
          local pairs = tsj:children({ 'pair' })
          for _, pair in ipairs(pairs) do
            for keyword in pair:iter_children() do
              local type = keyword:type()
              local needs_padding =
                type == 'map' or type == 'list' or type == 'tuple'
              if needs_padding then
                -- Grab the previous node which is the map key
                local map_key = keyword:prev()
                -- Add an extra space to account for keyword + map quirkness
                local text = map_key:text():gsub(':$', ': ')
                map_key:update_text(text)
              end
            end
          end
        end
      end,
    },
    split = {
      inner_indent = 'inner',
      last_separator = false,
    },
    join = {
      space_in_brackets = false,
    },
  }),
  arguments = lang_utils.set_preset_for_args(),
  tuple = lang_utils.set_preset_for_list({
    join = {
      space_in_brackets = false,
    },
    split = {
      recursive = false,
      last_separator = false,
    },
  }),
  binary_operator = {
    target_nodes = { 'list', 'map', 'tuple' },
  },
}
