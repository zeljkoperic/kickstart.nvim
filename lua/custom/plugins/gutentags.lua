return {
  'ludovicchabant/vim-gutentags',
  lazy = false,
  config = function()
    vim.cmd 'set tags+=tags,.git/tags'
    vim.g.gutentags_enabled = 1
    vim.g.gutentags_generate_on_missing = 1
    vim.g.gutentags_generate_on_write = 1
    vim.g.gutentags_resolve_symlinks = 1
    vim.g.gutentags_ctags_tagfile = '.git/tags'
    vim.g.gutentags_project_root = { '.git', 'package.json', 'composer.json' }
    vim.g.gutentags_ctags_extra_args = { '--fields=+l' }
    vim.g.gutentags_add_default_project_roots = 0
    vim.g.gutentags_ctags_executable_ruby = 'ripper-tags'
    vim.g.gutentags_ctags_extra_args_ruby = { '--ignore-unsupported-options', '--recursive' }
    -- vim.g.gutentags_cache_dir = vim.g.expand '~/.cache/vim/ctags/'
    vim.g.gutentags_generate_on_new = 1
    vim.g.gutentags_generate_on_empty_buffer = 0
    vim.g.gutentags_ctags_extra_args = {
      '--tag-relative=yes',
      '--fields=+aimnS',
    }
    -- vim.g.gutentags_ctags_extra_args = [
    --    '--tag-relative=yes',
    --    '--fields=+ailmnS',
    --    ]
    -- vim.g.gutentags_trace = 1
  end,
}
