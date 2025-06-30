return {
  {
    "nvim-neotest/nvim-nio"
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "folke/which-key.nvim",
    },
    config = function()
      require("config.dap")

      -- Add conditional breakpoint support with user input
      local dap = require("dap")
      local wk = require("which-key")

      -- Add function to set conditional breakpoints
      local function set_conditional_breakpoint()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
          if condition then
            dap.set_breakpoint(condition)
            vim.notify("Conditional breakpoint set: " .. condition, vim.log.levels.INFO)
          end
        end)
      end

      -- Add function to set logpoint (prints message without stopping)
      local function set_logpoint()
        vim.ui.input({ prompt = "Log message: " }, function(message)
          if message then
            dap.set_breakpoint(nil, nil, message)
            vim.notify("Logpoint set: " .. message, vim.log.levels.INFO)
          end
        end)
      end

      -- Let's revert to the old format that was working, no need to risk more errors
      wk.register({
        ["<leader>d"] = {
          name = "+debug",
          b = { "<cmd>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
          c = { "<cmd>DapContinue<CR>", "Start/Continue" },
          i = { "<cmd>DapStepInto<CR>", "Step Into" },
          o = { "<cmd>DapStepOver<CR>", "Step Over" },
          O = { "<cmd>DapStepOut<CR>", "Step Out" },
          r = { "<cmd>DapToggleRepl<CR>", "Toggle REPL" },
          l = { "<cmd>DapShowLog<CR>", "Show Log" },
          t = { "<cmd>DapTerminate<CR>", "Terminate" },
          u = { function() require("dapui").toggle() end, "Toggle UI" },
          B = { set_conditional_breakpoint, "Conditional Breakpoint" },
          p = { set_logpoint, "Log Point" },
        },
      })

      -- Register custom commands
      vim.api.nvim_create_user_command("DapConditionalBreakpoint", set_conditional_breakpoint, {})
      vim.api.nvim_create_user_command("DapLogPoint", set_logpoint, {})
    end,
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>",           desc = "Toggle breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<CR>",                   desc = "Start/Continue debugging" },
      { "<leader>dt", "<cmd>DapTerminate<CR>",                  desc = "Terminate DAP" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>di", "<cmd>DapStepInto<CR>",                   desc = "Step into" },
      { "<leader>do", "<cmd>DapStepOver<CR>",                   desc = "Step over" },
      { "<leader>dO", "<cmd>DapStepOut<CR>",                    desc = "Step out" },
      { "<leader>dr", "<cmd>DapToggleRepl<CR>",                 desc = "Toggle REPL" },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
            if condition then
              require("dap").set_breakpoint(condition)
              vim.notify("Conditional breakpoint set: " .. condition, vim.log.levels.INFO)
            end
          end)
        end,
        desc = "Set conditional breakpoint"
      },
      {
        "<leader>dp",
        function()
          vim.ui.input({ prompt = "Log message: " }, function(message)
            if message then
              require("dap").set_breakpoint(nil, nil, message)
              vim.notify("Logpoint set: " .. message, vim.log.levels.INFO)
            end
          end)
        end,
        desc = "Set log point"
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      display_callback = function(variable, buf, stackframe, node, options)
        return ' → ' .. variable.value
      end,
      virt_text_pos = 'eol',   -- 'eol' | 'inline'
      all_frames = false,      -- Show virtual text for all stack frames not only current
      virt_lines = false,      -- Show virtual lines instead of virtual text
      virt_text_win_col = nil, -- Position the virtual text at a fixed window column
    },
  },
  -- Remove problematic dap-repl-highlights plugin for now
  -- {
  --   "LiadOz/nvim-dap-repl-highlights",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = true,
  -- },
}
