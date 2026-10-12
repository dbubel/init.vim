# init.vim

Personal Neovim config (Lua, [lazy.nvim](https://github.com/folke/lazy.nvim) + Mason). Branch `lazy-mason`.

- Colorscheme: Catppuccin (mocha)
- LSP for Go, TypeScript, Terraform, Kubernetes YAML, Zig, Python, Lua, Bash, Docker, Markdown
- Completion: blink.cmp · Fuzzy finding: Telescope · Files: neo-tree + oil · Git: gitsigns
- Format on save: conform.nvim · Lint: nvim-lint (hadolint, golangci-lint)

Tested with Neovim 0.12.x on macOS (Apple Silicon, Homebrew).

## Setup

### 1. Prerequisites

```sh
brew install neovim git ripgrep fd node go zig terraform
```

- `ripgrep` / `fd`: Telescope grep and file search
- `node`: needed by Mason to install several servers and by `prettier`
- `go`, `terraform`, `zig`: toolchains for the languages configured
- A [Nerd Font](https://www.nerdfonts.com/) set in your terminal (icons)
- A C compiler (`xcode-select --install`) for Treesitter parsers
- Optional: `brew install macmon` for CPU temperature in the statusline (Apple Silicon, no sudo).
  Without it the temp segment is hidden and memory falls back to `vm_stat`.

### 2. Install the config

```sh
git clone -b lazy-mason https://github.com/dbubel/init.vim.git ~/.config/nvim
nvim
```

On first launch lazy.nvim bootstraps itself and installs the plugins pinned in
`lazy-lock.json`. Mason then installs the language servers, formatters and
linters listed in `lua/plugins/lsp.lua`. Wait for it to finish (`:Lazy`, `:Mason`),
then restart Neovim and run `:checkhealth`.

### 3. Zig / zls (manual step)

`zls` is **not** installed through Mason. Mason only ships zls 0.16, which doesn't
match Zig 0.17, so the config points at a locally built binary:

| Setting | Value |
| --- | --- |
| `zls` binary | `~/.local/bin/zls` |
| `zig_exe_path` | `/opt/homebrew/bin/zig` |

Build zls from source with the Zig 0.17 toolchain:

```sh
mkdir -p ~/.local/src ~/.local/bin
git clone https://github.com/zigtools/zls.git ~/.local/src/zls
cd ~/.local/src/zls
zig build -Doptimize=ReleaseSafe
cp zig-out/bin/zls ~/.local/bin/zls
```

Verify with `zig version` (expect `0.17.x`) and `~/.local/bin/zls --version`.
The current build is `0.17.0-dev.82+eab2be0f`; rebuild after upgrading Zig.

If your Zig lives elsewhere (e.g. Intel Mac, `/usr/local/bin/zig`), edit
`zig_exe_path` in `lua/plugins/lsp.lua`. Once zls 0.17.0 is tagged, delete the
`vim.lsp.config("zls", ...)` block and re-add `"zls"` to Mason's `ensure_installed`.

## Layout

```
init.lua                  leader keys, loads config.*
lua/config/               options, keymaps, autocmds, lazy bootstrap
lua/util/sysstats.lua     background CPU / temp / mem / disk / load sampling for lualine
lua/plugins/              one file per concern (lsp, completion, telescope, git, ...)
lazy-lock.json            pinned plugin versions
.stylua.toml              formatting rules for this repo's Lua
```

## Key bindings

Leader is `<Space>`. Press it and wait for which-key to list everything.

| Key | Action |
| --- | --- |
| `<leader><leader>` / `<leader>ff` | Find files |
| `<leader>fg` / `<leader>fw` | Live grep / grep word under cursor |
| `<leader>fb` / `<leader>fr` | Buffers / recent files |
| `<leader>/` | Search in buffer |
| `<leader>e` | File tree (neo-tree) |
| `<leader>f` | Format buffer |
| `<leader>xx` / `<leader>xX` | Diagnostics (all / buffer) via Trouble |
| `<leader>cs` | Symbols |
| `<leader>cd` | Line diagnostics |
| `<leader>th` | Toggle inlay hints |
| `<leader>ts` | Toggle system stats in the statusline |
| `<leader>gc` / `<leader>gs` | Git commits / status |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<C-h/j/k/l>` | Move between windows |
| `<C-s>` | Save |

`:FormatDisable[!]` pauses format-on-save (`!` = current buffer only); `:FormatEnable` resumes it.

## Maintenance

- `:Lazy update` updates plugins; commit the changed `lazy-lock.json`.
- `:Mason` manages servers and tools. Add new ones to `ensure_installed` in `lua/plugins/lsp.lua`.
