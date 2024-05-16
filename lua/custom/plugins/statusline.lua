return {
  {
    "tjdevries/express_line.nvim",
    config = function()
      require("custom.config.statusline").setup()
    end,
  },
}
