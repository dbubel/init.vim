return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio"
  },
  config = function()

    local dap, dapui = require("dap"), require("dapui")
    require("dap-go").setup()
    require("dapui").setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "do",function()
      require("dap").step_over()
    end)
    vim.keymap.set("n", "dsi", function()
      require("dap").step_into()
    end)
    vim.keymap.set("n", "dso", function()
      require("dap").step_out()
    end)
    vim.keymap.set("n", "<Leader>dt", function()
      require("dap").toggle_breakpoint()
    end)
    -- vim.keymap.set("n", "<Leader>B", function()
    vim.keymap.set("n", "<Leader>dx", function()
      require("dap").terminate()
    end)
    --   require("dap").set_breakpoint()
    -- end)
  end,
}
