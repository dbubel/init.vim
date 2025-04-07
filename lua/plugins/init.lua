-- Main plugin loader
return {
  -- Import all plugin modules
  require("plugins.lsp"),
  require("plugins.ui"),
  require("plugins.editor"),
  require("plugins.dap"),
  require("plugins.go"),
  require("plugins.vue"),
  require("plugins.c"),
}
