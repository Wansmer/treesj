local u = require('treesj.langs.utils')

return {
  table_constructor = u.set_preset_for_dict(),
  arguments = u.set_preset_for_args(),
  parameters = u.set_preset_for_args(),
  variable_declaration = {
    target_nodes = { 'table_constructor' },
  },
  assignment_statement = {
    target_nodes = { 'table_constructor' },
  },
}
