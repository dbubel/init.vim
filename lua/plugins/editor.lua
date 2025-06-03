return {
  -- Code outline/symbols viewer
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        layout = {
          default_direction = "right",
          placement = "edge",
          width = 30,
        },
        attach_mode = "global",
        filter_kind = false,
        icons = {
          Array = "󰅪 ",
          Boolean = " ",
          Class = "󰠱 ",
          Constant = "󰏿 ",
          Constructor = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = "󰈙 ",
          Function = "󰊕 ",
          Interface = " ",
          Key = "󰌋 ",
          Method = "󰆧 ",
          Module = " ",
          Namespace = "󰌗 ",
          Null = "󰟢 ",
          Number = "󰎠 ",
          Object = "󰅩 ",
          Operator = "󰆕 ",
          Package = " ",
          Property = " ",
          String = " ",
          Struct = "󰙅 ",
          TypeParameter = "󰊄 ",
          Variable = "󰆧 ",
        },
      })
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>", { desc = "Toggle Symbol Outline" })
      vim.keymap.set("n", "[s", "<cmd>AerialPrev<CR>", { desc = "Previous Symbol" })
      vim.keymap.set("n", "]s", "<cmd>AerialNext<CR>", { desc = "Next Symbol" })
    end,
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.telescope")
    end,
  },

  -- Git signs
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
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false,
      })
    end
  },

  -- Fugitive for Git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gdiffsplit" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gd", "<cmd>Gdiffsplit!<cr>", desc = "Git Diff Split" },
    },
    config = function()
      -- Key mappings for merge conflict resolution
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fugitive" },
        callback = function()
          -- Set local mappings for fugitive buffer
          vim.keymap.set("n", "<leader>gj", "<cmd>diffget //3<CR>", { buffer = true, desc = "Accept Theirs" })
          vim.keymap.set("n", "<leader>gf", "<cmd>diffget //2<CR>", { buffer = true, desc = "Accept Ours" })
        end,
      })
    end,
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
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          typescript = { "string", "template_string" },
          vue = { "string", "template_string" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },

  -- Signature help
  {
    "ray-x/lsp_signature.nvim",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      operators = { gc = "Comments" },
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
      window = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "center",
      },
      ignore_missing = false,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },
      show_help = true,
      show_keys = true,
      triggers = "auto",
      triggers_nowait = {
        -- marks
        "`",
        "'",
        "g`",
        "g'",
        -- registers
        '"',
        "<c-r>",
        -- spelling
        "z=",
      },
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Register key groups using new spec format
      wk.register({
        { "<leader>f", group = "find/telescope" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "harpoon" },
        { "<leader>t", group = "terminal" },
        { "<leader>x", group = "diagnostics/trouble" },
        { "<leader>w", group = "workspace" },
        { "<leader>c", group = "code" },
        { "<leader>m", group = "ui elements" },
        { "<leader>d", group = "debug" },
        { "<leader>a", group = "aerial/symbols" },
      })
      
      -- Let's revert to the old format that worked, just keeping the group registrations
      -- Register key groups first (using new format)
      wk.register({
        { "<leader>f", group = "find/telescope" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "harpoon" },
        { "<leader>t", group = "terminal" },
        { "<leader>x", group = "diagnostics/trouble" },
        { "<leader>w", group = "workspace" },
        { "<leader>c", group = "code" },
        { "<leader>m", group = "ui elements" },
        { "<leader>d", group = "debug" },
        { "<leader>a", group = "aerial/symbols" },
      })
      
      -- Register specific bindings with descriptions (old format that works)
      wk.register({
        -- Trouble
        ["<leader>x"] = {
          x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
          w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
          d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
          l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
          q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List" },
        },
        
        -- Telescope
        ["<leader>f"] = {
          f = { "<cmd>Telescope find_files<cr>", "Find Files" },
          g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
          b = { "<cmd>Telescope buffers<cr>", "Buffers" },
          h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
          r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
          s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in Buffer" },
          c = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
          p = { "<cmd>Telescope projects<cr>", "Projects" },
          t = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
        },
        
        -- Git
        ["<leader>g"] = {
          d = { "<cmd>DiffviewOpen<cr>", "Diff View" },
          D = { "<cmd>Gdiffsplit!<cr>", "Git Diff Split (Fugitive)" },
          h = { "<cmd>DiffviewFileHistory %<cr>", "Current File History" },
          H = { "<cmd>DiffviewFileHistory<cr>", "Git File History" },
          s = { "<cmd>Git<cr>", "Git Status (Fugitive)" },
          b = { "<cmd>Git blame<cr>", "Git Blame (Fugitive)" },
          c = { "<cmd>Git commit<cr>", "Git Commit (Fugitive)" },
          f = { "<cmd>diffget //2<cr>", "Accept Ours (in diff)" },
          j = { "<cmd>diffget //3<cr>", "Accept Theirs (in diff)" },
          i = { "<cmd>GoImports<cr>", "Run goimports" },
        },
        
        -- Harpoon
        ["<leader>h"] = {
          a = { function() require("harpoon"):list():append() end, "Add to Harpoon" },
          l = { function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, "Harpoon List" },
        },
        
        -- Terminal
        ["<leader>t"] = {
          t = { "<cmd>ToggleTerm direction=float<CR>", "Float Terminal" },
          h = { "<cmd>ToggleTerm direction=horizontal<CR>", "Horizontal Terminal" },
          v = { "<cmd>ToggleTerm direction=vertical<CR>", "Vertical Terminal" },
        },
        
        -- UI Elements
        ["<leader>m"] = {
          m = { function() require("codewindow").toggle_minimap() end, "Toggle Minimap" },
        },
        
        -- LSP Workspace
        ["<leader>w"] = {
          a = { function() vim.lsp.buf.add_workspace_folder() end, "Add Workspace Folder" },
          r = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove Workspace Folder" },
          l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List Workspace Folders" },
        },
        
        -- Buffer Navigation (Harpoon)
        ["<leader>1"] = { function() require("harpoon"):list():select(1) end, "Harpoon 1" },
        ["<leader>2"] = { function() require("harpoon"):list():select(2) end, "Harpoon 2" },
        ["<leader>3"] = { function() require("harpoon"):list():select(3) end, "Harpoon 3" },
        ["<leader>4"] = { function() require("harpoon"):list():select(4) end, "Harpoon 4" },

        -- Aerial (Symbol Outline)
        ["<leader>a"] = { "<cmd>AerialToggle<CR>", "Toggle Symbol Outline" },
      })
    end,
  },

  -- Trouble for better diagnostics display
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List" },
    },
    opts = {},
  },

  -- Better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      },
      func_map = {
        vsplit = "",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-t"] = "tab split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  -- Todo comments highlighting
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    },
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "Makefile", "package.json", "go.mod", "Cargo.toml", "vue.config.js", "nuxt.config.js", "vite.config.js", "CMakeLists.txt" },
        detection_methods = { "pattern", "lsp" },
        silent_chdir = true,
        show_hidden = true,
      })
      require("telescope").load_extension("projects")
    end,
  },

  -- Surround selections
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Add file to harpoon" })
      vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Show harpoon list" })
      
      -- Quick navigation to harpoon marks
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon buffer 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon buffer 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon buffer 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon buffer 4" })
    end,
  },

  -- Telescope extensions
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
