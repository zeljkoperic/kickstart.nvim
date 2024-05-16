local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme "tokyonight-night"

      -- You can configure highlights by doing something like:
      vim.cmd.hi "Comment gui=none"
    end,
  },

  { import = "custom.plugins" },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    size = { width = 0.9, height = 0.9 },
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }, -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
