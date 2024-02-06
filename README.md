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
*To install the latest zig daily and zls you need do the following:

mv zig-out/bin/zls ~/.local/share/nvim/mason/packages/zls/zls
cd ~/.local/share/nvim/mason/bin/
ln -s ~/.local/share/nvim/mason/packages/zls/zls
