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
          path = "dlv", -- Use the same path as in dap.lua
          -- time to wait for delve to initialize the debug session
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger
          -- Use the same fixed port as in dap.lua to avoid conflicts
          port = "38697",
          -- Additional arguments to pass to dlv
          args = { "--check-go-version=false" },
          -- Set to true to run Delve in detached mode (recommended on non-Windows)
          detached = true,
          -- Build flags to pass to the go compiler
          build_flags = "-gcflags='all=-N -l'"
        },
        -- Add custom configurations for debugging in specific modes
        dap_configurations = {
          {
            type = "go",
            name = "Debug Package",
            request = "launch",
            program = "${fileDirname}",
            args = function()
              local args_string = vim.fn.input("Arguments: ")
              return vim.split(args_string, " ", true)
            end,
          },
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
            port = function()
              return vim.fn.input("Port: ", "38697")
            end,
            host = function()
              return vim.fn.input("Host: ", "127.0.0.1")
            end,
          }
        },
        -- Test configurations
        tests = {
          -- Set to true to enable verbose output from tests
          verbose = true
        }
      })
    end,
    keys = {
      -- Go-specific debug keymaps with more distinct patterns
      { "<leader>gdt", "<cmd>lua require('dap-go').debug_test()<CR>",       desc = "Debug go test" },
      { "<leader>gdl", "<cmd>lua require('dap-go').debug_last_test()<CR>",  desc = "Debug last go test" },
      { "<leader>gdr", "<cmd>lua require('dap-go').debug_last()<CR>",       desc = "Run previous go config" },
      { "<leader>gdb", "<cmd>lua require('dap-go').debug_breakpoint()<CR>", desc = "Break at cursor" },
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
