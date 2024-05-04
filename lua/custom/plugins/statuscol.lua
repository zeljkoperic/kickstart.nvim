return {
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function()
    require('statuscol').setup {
      separator = ' ',
      setopt = true,
    }
  end,
}
