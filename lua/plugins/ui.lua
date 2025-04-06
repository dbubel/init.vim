return {
  -- Theme that can inherit terminal colors
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = true,
          treesitter = true,
          notify = true,
          mini = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("config.lualine")
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree <CR>", {})
      vim.keymap.set("n", "<leader>ex", ":Neotree toggle <CR>", {})
      
      require("neo-tree").setup({
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
          },
          modified = {
            symbol = "●",
          },
          git_status = {
            symbols = {
              added = "+",
              modified = "~",
              deleted = "-",
              renamed = "→",
              untracked = "?",
              ignored = "!",
              unstaged = "",
              staged = "✓",
              conflict = "!",
            }
          },
        }
      })
    end,
  },

  -- Enhanced Git integration
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git File History" },
    },
    opts = {
      enhanced_diff_hl = true,
      file_panel = {
        win_config = { width = 35 },
      },
    },
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { enabled = true },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Minimap for code overview
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        active_in_terminals = false,
        window_border = "rounded",
        minimap_width = 15,
        width_multiplier = 4,
        z_index = 10,
        use_lsp = true,
        use_treesitter = true,
        exclude_filetypes = { "NvimTree", "neo-tree", "dashboard", "Outline" },
      })
      vim.keymap.set("n", "<leader>mm", function() codewindow.toggle_minimap() end, { desc = "Toggle Minimap" })
    end,
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 3000,
        max_width = 60,
        max_height = 10,
        stages = "fade",
        render = "default",
        background_colour = "#000000",
      })
      vim.notify = notify
    end,
  },

  -- Icons
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require('mini.icons').setup()
      -- Make icons available globally
      vim.g.minicons = require('mini.icons')
    end,
  },
}
