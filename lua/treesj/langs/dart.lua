local lang_utils = require('treesj.langs.utils')

return {
  list_literal = lang_utils.set_preset_for_list({
    both = {
      shrink_node = { from = '[', to = ']' },
    },
  }),
  set_or_map_literal = lang_utils.set_preset_for_dict(),
  block = lang_utils.set_preset_for_statement(),
  arguments = lang_utils.set_preset_for_args(),
  formal_parameter_list = lang_utils.set_preset_for_args(),
  static_final_declaration = {
    target_nodes = {
      'list_literal',
      'set_or_map_literal',
    },
  },
  initialized_identifier = {
    target_nodes = {
      'list_literal',
      'set_or_map_literal',
    },
  },
}
