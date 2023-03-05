local u = require('treesj.langs.utils')

return {
  flow_sequence = u.set_preset_for_list({
    split = {
      last_separator = false,
      foreach = function(child)
        if child:is_first() or child:text() == ',' then
          child:_update_text('')
        elseif child:is_last() then
          child:_update_text('')
        else
          child:_update_text('- ' .. child:text())
        end
      end,
    },
  }),
  flow_mapping = u.set_preset_for_list({
    split = {
      last_separator = false,
      recursive = true,
      foreach = function(child)
        if child:is_first() or child:text() == ',' then
          child:_update_text('')
        elseif child:is_last() then
          child:_update_text('')
        end
      end,
    },
  }),
  block_sequence = u.set_preset_for_list({
    join = {
      non_bracket_node = true,
      add_framing_nodes = { left = ' [', right = ']' },
      last_separator = false,
      foreach = function(child)
        local text = child:text()
        text = string.gsub(text, '^- ', '')
        if not child:is_framing() then
          child:_update_text(text .. ',')
        end
      end,
    },
  }),
  block_mapping = u.set_preset_for_list({
    join = {
      non_bracket_node = true,
      add_framing_nodes = { left = ' {', right = '}' },
      last_separator = false,
      foreach = function(child)
        local text = child:text()
        if not child:is_framing() then
          child:_update_text(text .. ',')
        end
      end,
    },
  }),
}
