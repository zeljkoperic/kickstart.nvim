return {
  -- MASON and wrappers for it

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- LSP (works in pair with mason-lspconfig) and autocompletion

  { "williamboman/mason-lspconfig.nvim" },
  {
    "lvimuser/lsp-inlayhints.nvim",
    lazy = fales,
    config = function()
      require("lsp-inlayhints").setup()
    end
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      {
        "neovim/nvim-lspconfig",
        config = function()
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
              --
              local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
              end

              --  To jump back, press <C-t>.
              map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
              map("<F8>", ":TagbarToggle<CR>", "Toggle Tagbar")
              -- Find references for the word under your cursor.
              map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
              map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
              map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
              map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
              map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
              map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
              map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
              map("K", vim.lsp.buf.hover, "Hover Documentation")
              map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

              local client = vim.lsp.get_client_by_id(event.data.client_id)
              if client and client.server_capabilities.documentHighlightProvider then
                local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                  buffer = event.buf,
                  group = highlight_augroup,
                  callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd("LspDetach", {
                  group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                  callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
                  end,
                })
              end

              if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                map("<leader>th", function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, "[T]oggle Inlay [H]ints")
              end
            end,
          })
        end
      }, -- Required

      -- Autocompletion
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "folke/neodev.nvim",       opts = {} },
      { "j-hui/fidget.nvim",       opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    init = function()
      local lsp = require("lsp-zero").preset {}

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps { buffer = bufnr }
        -- local opts = { noremap = true, silent = true }
        -- local keymap = vim.api.nvim_buf_set_keymap
        -- keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        -- keymap(bufnr, "n", "gA", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        -- keymap(bufnr, "n", "gF", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
        -- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        -- keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
        -- keymap(bufnr, "n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        -- keymap(bufnr, "n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        -- keymap(bufnr, "n", "gh", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

        -- disable virtual text
        vim.diagnostic.config {
          virtual_text = false,
        }
      end)

      require("mason").setup {

        ui = {
          border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "tailwindcss",
          "intelephense",
          "ansiblels",
          "bashls",
          "docker_compose_language_service",
          "dockerls",
          "eslint",
          "ltex",
          --"groovyls",
          "helm_ls",
          "html",
          "jsonls",
          "terraformls",
          "tsserver",
          "yamlls",
          "pylsp",
          --"ruff_lsp",
          "taplo",
          "marksman",
        },
      }

      -- Here we can add custom settings for each LSP
      --
      local lsp_config = require "lspconfig"

      -- default setups
      lsp_config.ansiblels.setup {}
      lsp_config.ruff_lsp.setup {}
      lsp_config.bashls.setup {}
      lsp_config.dockerls.setup {}
      lsp_config.docker_compose_language_service.setup {}
      lsp_config.eslint.setup {}
      lsp_config.groovyls.setup {}
      lsp_config.helm_ls.setup {}
      lsp_config.html.setup {}
      lsp_config.jsonls.setup {}
      lsp_config.terraformls.setup {}
      lsp_config.tsserver.setup {}
      lsp_config.taplo.setup {}
      lsp_config.marksman.setup {}
      lsp_config.tailwindcss.setup {}
      --

      lsp_config.pylsp.setup {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = {
                  "E501", -- conflict with ruff: line too long
                  "W503", -- conflict with ruff: line break before binary operator
                },
              },
            },
          },
        },
      }
      lsp_config.lua_ls.setup(lsp.nvim_lua_ls())

      lsp_config.intelephense.setup {
        root_dir = function(startPath)
          local rp = (require "lspconfig.util").root_pattern
          for _, pattern in pairs {
            ".thisIsDocRoot",
            "index.php",
            ".git",
            "node_modules",
            "composer.json",
          } do
            local found = rp { pattern } (startPath)
            -- print(pattern, found)
            if found and found ~= "" then
              return found
            end
          end
          return nil
        end,
        settings = {
          editor = {
            tabSize = 4,
            -- spaces not tabs
            insertSpaces = true,
            -- the detection is annoying, but this line doesn't seem to stop it.
            detectIndentation = true,
          },
          -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md
          intelephense = {
            files = { associations = { "*.php", "*.module", "*.inc", "*.htm", "*.html" } },
            environment = {
              phpVersion = "8.1.22",
              shortOpenTag = true,
            },
            format = { braces = "psr12" }, -- alternative values: psr12 or allman
            completion = {
              insertUseDeclaration = true,
              fullyQualifyGlobalConstantsAndFunctions = false,
              triggerParameterHints = true,
              maxItems = 100,
            },
          },
        },
      }
      lsp_config.ltex.setup {
        settings = {
          ltex = {
            language = "en-US",
            enabled = true,
            dictionary = {
              ["en-US"] = spell_words,
            },
          },
          filetypes = {
            "markdown",
            "text",
            "NeogitCommitMessage",
            "gitcommit",
          },
        },
      }
      lsp_config.yamlls.setup {
        settings = {
          yaml = {
            customTags = {
              "!reference sequence",
            },
            schemas = {
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                ".gitlab-ci.{yml, yaml}",
                "gitlab-ci/**/*.{yml, yaml}",
              },
            },
          },
        },
      }
      --
      --

      require("lsp-zero").extend_cmp()

      local cmp = require "cmp"
      local luasnip = require "luasnip"

      require("luasnip.loaders.from_snipmate").load()

      cmp.setup {
        -- completion = {
        --     autocomplete = false
        -- },

        formatting = {
          format = function(entry, vim_item)
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              luasnip = "[Snip]",
            })[entry.source.name]
            return vim_item
          end,
        },

        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer",  keyword_length = 3 },
          { name = "luasnip" },
        },

        mapping = {
          ["<C-n>"] = function()
            if cmp.visible() then
              cmp.close()
            else
              cmp.complete()
            end
          end,

          ["<Up>"] = cmp.config.disable,
          ["<Down>"] = cmp.config.disable,

          -- Use Tab and shift-Tab to navigate autocomplete menu
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,

          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(0) then
              luasnip.jump(0)
            else
              fallback()
            end
          end,

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
        },

        -- `/` cmdline setup.
        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        }),

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }, {
            { name = "buffer", max_item_count = 16 },
          }),
        }),
      }
    end,
  },

  -- linters

  {
    "mfussenegger/nvim-lint",
    config = function()
      -- i comment this out, because linter should use strict config from repo
      ---- update with new args
      --local ruff = require("lint").linters.ruff

      --local new_args = {
      --	"--select",
      --	"ALL",
      --	"--no-cache",
      --}
      --local ruff_args = {}
      --local n = 0
      --for _, v in ipairs(new_args) do
      --	n = n + 1
      --	ruff_args[n] = v
      --end
      --for _, v in ipairs(ruff.args) do
      --	n = n + 1
      --	ruff_args[n] = v
      --end

      --ruff.args = ruff_args
      ----

      require("lint").linters_by_ft = {
        python = { "ruff" },
        json = { "jsonlint" },
      }
    end,
  },

}
