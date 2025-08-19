# Neovim Configuration

A modern, feature-rich Neovim configuration focused on development productivity with language-specific support for Go, Vue, Zig, Terraform, and C/C++.

## Features

### 🎨 UI & Appearance
- **Catppuccin Mocha** theme with transparent background
- **Lualine** status line with Git integration
- **Neo-tree** file explorer with custom icons
- **Aerial** symbol outline/code navigation
- **Indent guides** with scope highlighting
- **Code minimap** for file overview
- **Notification system** with nvim-notify

### 📝 Editor Enhancements
- **Telescope** fuzzy finder for files, live grep, and more
- **Treesitter** for syntax highlighting and code parsing
- **Auto-pairs** with smart bracket completion
- **Surround** text objects for quick editing
- **Comment** toggle with `gc`/`gcc`
- **TODO comments** highlighting and search
- **Terminal integration** with ToggleTerm

### 🔧 Development Tools
- **LSP** with Mason package manager for language servers
- **Auto-completion** with nvim-cmp and snippets
- **Auto-formatting** on save with conform.nvim
- **Signature help** during function calls
- **Trouble** for better diagnostics display
- **Git integration** with Gitsigns, Fugitive, and Diffview

### 🚀 Navigation & Productivity
- **Harpoon** for quick file switching (marks 1-4)
- **Project management** with automatic detection
- **Quickfix enhancements** with nvim-bqf
- **Symbol navigation** with Aerial

## Language Support

### Go
- gopls language server
- goimports and gofumpt formatting
- Debugging with nvim-dap

### Vue.js/JavaScript/TypeScript
- Vetur language server
- Prettier formatting
- Vue-specific configurations

### Zig
- ZLS language server
- zigfmt formatting

### Terraform
- terraform-ls language server
- terraform_fmt formatting

### C/C++
- Language server support
- Debugging configurations

### Others
- Python (python_lsp_server)
- Lua (lua-language-server + stylua)
- YAML (yaml-language-server)
- JSON formatting

## Key Bindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<leader>e` | Open file explorer |
| `<leader>ex` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>ha` | Add to Harpoon |
| `<leader>hl` | Show Harpoon list |
| `<leader>1-4` | Jump to Harpoon marks |
| `<leader>a` | Toggle symbol outline |
| `<leader>gs` | Git status |
| `<leader>gd` | Git diff view |
| `<leader>xx` | Toggle diagnostics |
| `<Ctrl-\>` | Toggle floating terminal |

## Installation

1. Clone this configuration to your Neovim config directory:
   ```bash
   git clone <your-repo> ~/.config/nvim
   ```

2. Install required Mason packages by running `:Mason` in Neovim and installing:

### Required Mason installs

- `gopls`
- `*zls`
- `gofumpt`
- `lua-language-server`
- `stylua`
- `jq`
- `python_lsp_server`
- `terraform-ls`
- `yaml-language-server`
- `goimports`
- `vetur-vls`

*To install the latest zig daily and zls you need do the following:

mv zig-out/bin/zls ~/.local/share/nvim/mason/packages/zls/zls
cd ~/.local/share/nvim/mason/bin/
ln -s ~/.local/share/nvim/mason/packages/zls/zls

## Structure

```
lua/
├── core/
│   ├── keymaps.lua    # Key mappings
│   └── options.lua    # Vim options
├── config/
│   ├── cmp.lua        # Completion configuration
│   ├── dap.lua        # Debug adapter protocol
│   ├── lsp.lua        # Language server setup
│   ├── lualine.lua    # Status line config
│   ├── telescope.lua  # Fuzzy finder setup
│   └── treesitter.lua # Syntax highlighting
└── plugins/
    ├── init.lua       # Plugin loader
    ├── lsp.lua        # LSP and completion plugins
    ├── ui.lua         # UI and appearance plugins
    ├── editor.lua     # Editor enhancement plugins
    ├── dap.lua        # Debugging plugins
    └── [lang].lua     # Language-specific plugins
```

## Requirements

- Neovim >= 0.9
- Git
- A Nerd Font for icons
- ripgrep (for live grep)
- fd (for file finding)
- Node.js (for some LSP servers)

