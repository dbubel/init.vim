return {
  {
    "nvim-neotest/nvim-nio"
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("config.dap")
    end,
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Add breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<CR>",         desc = "Start/Continue debugging" },
      { "<leader>di", "<cmd>DapStepInto<CR>",         desc = "Step into" },
      { "<leader>do", "<cmd>DapStepOver<CR>",         desc = "Step over" },
      { "<leader>dO", "<cmd>DapStepOut<CR>",          desc = "Step out" },
      { "<leader>dr", "<cmd>DapToggleRepl<CR>",       desc = "Toggle REPL" },
      { "<leader>dl", "<cmd>DapShowLog<CR>",          desc = "Show DAP log" },
      { "<leader>dt", "<cmd>DapTerminate<CR>",        desc = "Terminate DAP" },
    },
  },
}
