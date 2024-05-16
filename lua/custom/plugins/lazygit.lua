return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
    { '<leader>ll', '<cmd>Lazy<cr>', desc = '[L]azy' },
    { '<leader>lm', '<cmd>Mason<cr>', desc = '[M]ason' },
    { '<leader>lc', '<cmd>Copilot panel<cr>', desc = '[C]opilot panel' },
    { '<leader>ld', '<cmd>DBUIToggle<cr>', desc = '[D]B UI Toggle' },
    { '<leader>lt', '<cmd>NvimTreeToggle<cr>', desc = 'NVIM [T]ree Toggle' },
  },
}
