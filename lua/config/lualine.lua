-- Status line configuration
require("lualine").setup({
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "alpha" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 
      { "mode", separator = { left = "", right = "" }, right_padding = 2 },
    },
    lualine_b = { 
      { "branch", icon = "" },
      { "diff", 
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = "#98be65" },
          modified = { fg = "#ecbe7b" },
          removed = { fg = "#ec5f67" },
        },
      },
      { 
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
    },
    lualine_c = { 
      { "filename", path = 1, file_status = true },
    },
    lualine_x = { 
      { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 1 } },
      { "encoding" },
      { "fileformat" },
    },
    lualine_y = { "progress" },
    lualine_z = { 
      { "location", separator = { left = "", right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "neo-tree", "lazy", "trouble", "mason" },
})
