return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = {
      filetypes = {
        gitcommit = true,
        NeogitCommitMessage = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Bslash>j",
          accept_word = false,
          accept_line = false,
          next = "<Bslash>d",
          prev = "<Bslash>s",
          dismiss = "<Bslash>a",
        },
      },
    },
  },
}
-- return {
-- 	"github/copilot.vim",
-- }
