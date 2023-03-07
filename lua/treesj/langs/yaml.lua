local u = require('treesj.langs.utils')

local remove_last = function(children)
  local last = children[#children]
  if last then
    last:remove()
  end
  return children
end

return {
  flow_sequence = u.set_preset_for_list({
    split = {
      last_separator = false,
      force_insert = ',',
      no_insert_if = { u.no_insert.if_penultimate },
      lifecycle = {
        before_build_tree = function(children, p)
          return vim.tbl_filter(function(child)
            return child:type() ~= p.separator
          end, children)
        end,
        after_build_tree = function(children)
          for _, child in ipairs(children) do
            if child:is_first() then
              child:update_text('')
            else
              child:update_text('- ' .. child:text())
            end
          end
          return remove_last(children)
        end,
      },
    },
  }),
  flow_mapping = u.set_preset_for_list({
    split = {
      last_separator = false,
      recursive = true,
      lifecycle = {
        before_build_tree = function(children, p)
          return vim.tbl_filter(function(child)
            return child:type() ~= p.separator
          end, children)
        end,
        after_build_tree = function(children)
          return remove_last(u.helper.replacer(children, { ['{'] = '' }))
        end,
      },
    },
  }),
  block_sequence = u.set_preset_for_list({
    join = {
      non_bracket_node = true,
      add_framing_nodes = { left = ' [', right = ']' },
      force_insert = ',',
      no_insert_if = { u.no_insert.if_penultimate },
      lifecycle = {
        after_build_tree = function(children)
          for _, child in ipairs(children) do
            local text = child:text()
            if type(text) == 'string' then
              child:update_text(child:text():gsub('^- ', ''))
            end
          end
          return children
        end,
      },
    },
  }),
  block_mapping = u.set_preset_for_list({
    join = {
      non_bracket_node = true,
      force_insert = ',',
      no_insert_if = { u.no_insert.if_penultimate },
      add_framing_nodes = { left = ' {', right = '}' },
    },
  }),
}
