-- init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Plugin specification
require("lazy").setup({
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
      local dap = require("dap")
      local dapui = require("dapui")

      -- DAP UI setup
      dapui.setup()

      -- Automatically open dapui when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Automatically close dapui when debugging ends
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      -- Add your preferred keymaps here
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
  {
    "ray-x/lsp_signature.nvim",
    -- event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>/", function()
        require("Comment.api").toggle.linewise.current()
      end)
      vim.keymap.set(
        "v",
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
      )
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.goimports,
        },
      })
    end,
  },
  -- NvTerm (Terminal Plugin)
  {
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup({
        terminals = {
          shell = vim.o.shell,
          list = {},
          type_opts = {
            float = {
              relative = 'editor',
              row = 0.1,
              col = 0.1,
              width = 0.8,
              height = 0.7,
              border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = 0.3 },
            vertical = { location = "rightbelow", split_ratio = 0.5 }
          }
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        }
      })
    end,
  },
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      })
    end
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      autopairs.setup({
        check_ts = true, -- Enable treesitter support
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>", -- Alt+e to quickly wrap
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment"
        },
      })

      -- Integration with nvim-cmp
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },

  -- Theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree <CR>", {})
      vim.keymap.set("n", "<leader>ex", ":Neotree toggle <CR>", {})
    end,
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      -- Call the lualine setup function within the config block
      require("lualine").setup({
        options = {
          theme = "auto", -- You can change this to any theme you prefer
          section_separators = { "", "" },
          component_separators = { "", "" },
          icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },

})

-- Mason and LSP configuration
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls",
    "lua_ls",
  },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Go LSP setup
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- Lua LSP setup
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "lua", "vim", "vimdoc", "query", "sql" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})

-- Telescope configuration
local telescope = require("telescope")
telescope.setup({})

-- Keymaps
local keymap = vim.keymap.set
-- Gitsigns keymaps (add to existing keymaps section)
keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
keymap("n", "<leader>hD", ":Gitsigns diffthis<CR>", { desc = "Show git diff" })
keymap("n", "<leader>hf", ":Gitsigns next_hunk<CR>", { desc = "Go to next git hunk" })
keymap("n", "<leader>hb", ":Gitsigns prev_hunk<CR>", { desc = "Go to previous git hunk" })
keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })

-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- System clipboard keymaps
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Saving and command mode
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", ";", ":", { desc = "Quick command mode" })

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Line number toggles
keymap("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
keymap("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- Buffer management
keymap("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
keymap("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close current buffer" })


-- Terminal toggle keymaps (additional to existing keymaps section)
local terminal = require("nvterm.terminal")

-- Normal mode terminal toggle
keymap("n", "<leader>i", function()
  terminal.toggle("float")
end, { desc = "Toggle floating terminal" })

keymap("t", "<leader>i", function()
  terminal.toggle("float")
end, { desc = "Toggle floating terminal" })

-- Terminal mode escape mapping (optional, but helpful)
keymap("t", "<ESC>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- Optional: Additional terminal mode keymaps for different terminal types
keymap("n", "<leader>ih", function()
  terminal.toggle("horizontal")
end, { desc = "Toggle horizontal terminal" })

keymap("n", "<leader>iv", function()
  terminal.toggle("vertical")
end, { desc = "Toggle vertical terminal" })

-- Copilot-related keymaps (add to existing keymaps section)
-- Open Copilot panel
keymap("n", "<leader>cp", function()
  require("copilot.panel").open()
end, { desc = "Open Copilot Panel" })

-- Manually trigger Copilot suggestion
keymap("i", "<M-t>", function()
  require("copilot.suggestion").toggle_auto_trigger()
end, { desc = "Toggle Copilot Auto Trigger" })

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufopts = { noremap = true, silent = true, buffer = args.buf }
    keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap("n", "gr", require('telescope.builtin').lsp_references, bufopts)
    keymap("n", "ra", vim.lsp.buf.rename, bufopts)
    keymap("n", "K", vim.lsp.buf.hover, bufopts)
    keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap("n", "<leader>fm", vim.lsp.buf.format, bufopts)
  end,
})


-- Status line configuration
require("lualine").setup({
  options = {
    theme = "rose-pine",
  },
})
