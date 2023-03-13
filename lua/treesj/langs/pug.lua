local lang_utils = require('treesj.langs.utils')

return {
  attributes = lang_utils.set_default_preset(),
  tag = {
    target_nodes = { 'attributes' },
  },
}
