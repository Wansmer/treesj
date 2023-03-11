local lang_utils = require('treesj.langs.utils')

return {
  arguments = lang_utils.set_preset_for_args({
    both = {
      non_bracket_node = true,
    },
    split = {
      recursive_ignore = { 'subset' },
    },
  }),

  formal_parameters = lang_utils.set_preset_for_args({
    split = {
      recursive_ignore = { 'subset' },
    },
  }),

  left_assignment = {
    target_nodes = {
      'arguments',
      'formal_parameters',
    },
  },

  super_assignment = {
    target_nodes = {
      'arguments',
      'formal_parameters',
    },
  },

  right_assignment = {
    target_nodes = {
      'arguments',
      'formal_parameters',
    },
  },

  super_right_assignment = {
    target_nodes = {
      'arguments',
      'formal_parameters',
    },
  },

  equals_assignment = {
    target_nodes = {
      'arguments',
      'formal_parameters',
    },
  },

  function_definition = {
    target_nodes = { 'formal_parameters' },
  },

  call = {
    target_nodes = { 'arguments' },
  },

  binary = {
    target_nodes = { 'arguments' },
  },

  pipe = {
    target_nodes = { 'arguments' },
  },
}
