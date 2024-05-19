return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "dockerfile",
      "gitignore",
      "vim",
      "vimdoc",
      "json",
      "javascript",
      "typescript",
      "php",
      "css",
      "scss",
      "yaml",
      "toml",
      "python",
      "rust",
      "go",
      "sql",
    },

    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
    require("nvim-treesitter.configs").setup {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      autotag = {
        enable = true,
      },
      ensure_installed = { "markdown", "markdown_inline" },
      highlight = {
        enable = true,
      },
    }
  end,
}
