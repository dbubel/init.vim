return {
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dap-go").setup({
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging
          path = "dlv",
          -- time to wait for delve to initialize the debug session
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port
          port = "${port}",
        },
      })
    end,
    keys = {
      -- Add Go-specific debug keymaps here
      { "<leader>dgt", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug go test" },
      { "<leader>dgl", "<cmd>lua require('dap-go').debug_last()<CR>", desc = "Debug last go test" },
    },
  },
  -- Go test stuff
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({})
      vim.keymap.set("n", "<leader>tf", ":GoTestFunc -v <CR>", {})
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "crusj/structrue-go.nvim",
    branch = "main",
    config = function()
      require("structrue-go").setup()
    end,
  },
  {
    "crusj/hierarchy-tree-go",
    config = function()
      require("hierarchy-tree-go").setup({})
    end,
  },
}
