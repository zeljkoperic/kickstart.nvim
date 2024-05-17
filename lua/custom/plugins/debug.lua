return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local sign = vim.fn.sign_define
    sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

    require("mason-nvim-dap").setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "php",
      },
    }
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = {
        vim.loop.os_homedir() .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
      },
    }
    -- Config for a VVV (Vagrant) WordPress site
    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for VVV Xdebug",
        port = 9003,
        localSourceRoot = "~/repos/github.com/zeljkoperic/iptvpanel2/src",
        -- localSourceRoot = vim.fn.expand("%:p:h").."/",
        serverSourceRoot = "/opt/iptvpanel2/portal",
      },
    }

    dap.configurations.php = {
      {
        name = "run current script",
        type = "php",
        request = "launch",
        port = 9003,
        cwd = "${fileDirname}",
        program = "${file}",
        runtimeExecutable = "php",
      },
      -- to listen to any php call
      {
        name = "listen for Xdebug local",
        type = "php",
        request = "launch",
        port = 9003,
      },
      -- to listen to php call in docker container
      {
        name = "listen for Xdebug docker",
        type = "php",
        request = "launch",
        port = 9003,
        log = true,
        -- this is where your file is in the container
        pathMappings = {
          ["/opt/iptvpanel2/portal"] = "${workspaceFolder}/src",
        },
      },
    }
    dap.defaults.php.exception_breakpoints = { "Notice", "Warning", "Error", "Exception" }
    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { desc = "Debug: Set Breakpoint" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },

      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes",      size = 0.4 },
            { id = "breakpoints", size = 0.15 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.20 },
          },
          size = 60,
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.4 },
            { id = "console", size = 0.6 },
          },
          size = 20,
          position = "bottom",
        },
      },
      size = 65,
      position = "left", -- Can be "left", "right", "top", "bottom"
      expand_lines = false,
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    require("dap-go").setup()
  end,
}
