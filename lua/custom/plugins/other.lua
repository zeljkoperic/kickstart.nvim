return {
  { 'tpope/vim-sleuth', enabled = false },
  {
    'jeffkreeftmeijer/vim-numbertoggle',
    lazy = false,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    config = function()
      require('nvim-highlight-colors').setup {}
    end,
  },
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    keys = {
      { '<leader>gb', '<cmd>BlameToggle virtual<CR>', desc = '[G]it [b]lame' },
    },
    config = function()
      require('blame').setup()
    end,
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = { 'DiffviewOpen', 'DiffviewClose' },
    keys = {
      {
        '<leader>gd',
        function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd 'DiffviewOpen'
          else
            vim.cmd 'DiffviewClose'
          end
        end,
        desc = '[G]it [d]iff',
      },
    },
    config = function()
      require('diffview').setup {
        view = {
          file_history = {
            layout = 'diff2_vertical',
          },
        },
      }
    end,
  },
  {
    'gen740/SmoothCursor.nvim',
    event = 'VeryLazy',
    config = function()
      require('smoothcursor').setup {
        disable_float_win = true,
        disabled_filetypes = { 'TelescopePrompt' },
        cursor = '',
        texthl = 'String',
      }
    end,
  },
  {
    'preservim/tagbar',
  },
  {
    'liuchengxu/vista.vim',
    --TODO: uraditi check za ctags pa tek onda enable vista
    --    enabled = function()
    --      if utils.executable 'ctags' then
    --        return true
    --      else
    --        return false
    --      end
    --    end,
    cmd = 'Vista',
  },
  {
    'theHamsta/nvim-dap-virtual-text',
  },
}