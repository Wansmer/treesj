local u = require('treesj.langs.utils')

return {
  array = u.set_preset_for_list(),
  hash = u.set_preset_for_list(),
  assignment = { target_nodes = { 'array', 'hash' } },
  method = { target_nodes = { 'body_statement' } },
}
