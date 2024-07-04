local lang_utils = require('treesj.langs.utils')

return {
  arguments = lang_utils.set_preset_for_args({
    both = {
      separator = 'comma',
    },
    split = {
      recursive_ignore = { 'subset' },
    },
  }),

  parameters = lang_utils.set_preset_for_args({
    both = {
      separator = 'comma',
    },
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

  binary_operator = {
    target_nodes = { 'arguments', 'parameters' },
  },

  pipe = {
    target_nodes = { 'arguments' },
  },
}
