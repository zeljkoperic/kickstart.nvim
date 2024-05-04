return {
  'kevinhwang91/nvim-ufo',
  enabled = false,
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'BufRead',
  keys = {
    {
      'co',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open all folds',
    },
    {
      'cc',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close all folds',
    },
    {
      'cp',
      function()
        require('ufo').peekFoldedLinesUnderCursor()
      end,
      desc = 'Peek folded lines under cursor',
    },
  },
  opts = {
    open_fold_hl_timeout = 0,
    fold_virt_text_handler = function(text, lnum, endLnum, width)
      local suffix = '  '
      local lines = ('[%d lines] '):format(endLnum - lnum)

      local cur_width = 0
      for _, section in ipairs(text) do
        cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
      end

      suffix = suffix .. (' '):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)

      table.insert(text, { suffix, 'Comment' })
      table.insert(text, { lines, 'Todo' })
      return text
    end,
    preview = {
      win_config = {
        border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
        winblend = 0,
        winhighlight = 'Normal:LazyNormal',
      },
    },
  },
}
