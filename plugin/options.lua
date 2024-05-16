--
-- Global
vim.g.autoformat = true
vim.opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.listchars = {
  tab = ">>>",
  trail = "·",
  precedes = "←",
  extends = "→",
  nbsp = "␣",
}
local opt = vim.opt
-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes:1"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
opt.sidescrolloff = 8 -- Columns of context

opt.autowrite = true -- Enable auto write
opt.foldnestmax = 4
opt.foldlevel = 1
opt.foldcolumn = "1"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldmethod = "expr"
opt.foldlevelstart = 99
opt.foldenable = true
-- opt.showtabline = 2
opt.backupcopy = "yes"
opt.undolevels = 10000
opt.shortmess:append { W = true, I = true, c = true, C = true }
-- opt.shortmess:append { c = true, S = true }
opt.hidden = true
opt.wrapscan = true
opt.backup = false
opt.writebackup = false
opt.showcmd = true
opt.showmatch = true
opt.errorbells = false
opt.joinspaces = false
opt.title = true
opt.encoding = "UTF-8"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.laststatus = 3
opt.splitkeep = "screen"
opt.termguicolors = true -- True color support
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
-- opt.wrap = false -- Disable line wrap
opt.fileformat = "unix"
opt.tabstop = 2
opt.spelllang = "en"
opt.softtabstop = 2
opt.swapfile = false
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 2
--opt.number = true
opt.colorcolumn = "+1"
opt.list = true
--opt.relativenumber = false
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line "'\""
    if last_pos > 0 and last_pos <= vim.fn.line "$" then
      vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

if vim.fn.has "nvim-0.10" == 1 then
  opt.smoothscroll = true
end
