return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>ts",
        function()
          require("util.sysstats").toggle()
        end,
        desc = "Toggle system stats",
      },
    },
    opts = function()
      local sysstats = require("util.sysstats")
      sysstats.start()
      return {
        options = {
          theme = "catppuccin-mocha",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = vim.list_extend(sysstats.components(), {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                  return ""
                end
                return " " .. table.concat(
                  vim.tbl_map(function(c)
                    return c.name
                  end, clients),
                  ","
                )
              end,
            },
            "filetype",
          }),
        },
      }
    end,
  },

  -- Discoverable keymaps: pause after <leader> to see what's available
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunk" },
        { "<leader>t", group = "toggle" },
        { "<leader>x", group = "diagnostics" },
      },
    },
  },

  -- Quality-of-life collection: dashboard, notifications, indent guides, lazygit, ...
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>bo",
        function()
          Snacks.bufdelete.other()
        end,
        desc = "Delete other buffers",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle scratch buffer",
      },
    },
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true, animate = { enabled = false } },
      notifier = { enabled = true, timeout = 3000 },
      quickfile = { enabled = true },
      words = { enabled = true }, -- highlight other uses of the symbol under cursor
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat({
            "                                                    ",
            " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                    ",
          }, "\n"),
        },
      },
    },
  },
}
