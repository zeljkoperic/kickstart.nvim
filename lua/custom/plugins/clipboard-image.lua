return {
  "HakonHarnes/img-clip.nvim",
  ft = "markdown",
  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
  },
  config = function()
    require("img-clip").setup {
      filetypes = {
        markdown = {
          dir_path = vim.fn.getcwd() .. "/.assets",
          relative_template_path = false,
          file_name = "%Y-%m-%d-%H-%M-%S", -- file name format (see lua.org/pil/22.1.html)
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",

          drag_and_drop = {
            download_images = false,
          },
        },
      },
    }
  end,
}
