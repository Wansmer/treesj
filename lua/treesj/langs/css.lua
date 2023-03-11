local lang_utils = require('treesj.langs.utils')

return {
  block = lang_utils.set_preset_for_statement({
    join = {
      force_insert = '',
    },
  }),
  keyframe_block_list = lang_utils.set_preset_for_statement({
    join = {
      force_insert = '',
    },
  }),
  arguments = lang_utils.set_preset_for_args(),
  call_expression = {
    target_nodes = { 'arguments' },
  },
  rule_set = {
    target_nodes = { 'block' },
  },
  media_statement = {
    target_nodes = { 'block' },
  },
  keyframes_statement = {
    target_nodes = { 'keyframe_block_list' },
  },
  supports_statement = {
    target_nodes = { 'block' },
  },
  at_rule = {
    target_nodes = { 'block' },
  },
}
