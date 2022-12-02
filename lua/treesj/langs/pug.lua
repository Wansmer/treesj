local u = require('treesj.langs.utils')

return {
  attributes = u.set_default_preset(),
  tag = {
    target_nodes = { 'attributes' },
  },
}
