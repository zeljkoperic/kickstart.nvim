return {
  'm4xshen/hardtime.nvim',
  command = 'Hardtime',
  event = 'BufEnter',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
  },
  -- opts = {
  --   disable_mouse = false,
  -- },
  config = function()
    require 'custom.config.hardtime'
  end,
}
