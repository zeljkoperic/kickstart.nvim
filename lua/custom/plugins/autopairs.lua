return {
  'windwp/nvim-autopairs',
  event = { 'InsertEnter' },
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require 'custom.config.nvim-autopairs'
  end,
}
