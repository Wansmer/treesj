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
      foreach = function(child)
        if child:is_first() or child:text() == ',' then
          child:update_text('')
        elseif child:is_last() then
          child:update_text('')
        else
          child:update_text('- ' .. child:text())
        end
      end,
      lifecycle = {
        after_build_tree = remove_last,
      },
    },
  }),
  flow_mapping = u.set_preset_for_list({
    split = {
      last_separator = false,
      recursive = true,
      foreach = function(child)
        if child:is_first() or child:text() == ',' then
          child:update_text('')
        elseif child:is_last() then
          child:update_text('')
        end
      end,
      lifecycle = {
        after_build_tree = remove_last,
      },
    },
  }),
  block_sequence = u.set_preset_for_list({
    join = {
      non_bracket_node = true,
      add_framing_nodes = { left = ' [', right = ']' },
      force_insert = ',',
      no_insert_if = { u.no_insert.if_penultimate },
      foreach = function(child)
        local text = child:text()
        text = string.gsub(text, '^- ', '')
        if not child:is_framing() then
          child:update_text(text)
        end
      end,
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
