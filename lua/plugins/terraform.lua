return {
  -- Terraform language support
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "terraform-vars", "hcl" },
    config = function()
      -- Auto format on save
      vim.g.terraform_fmt_on_save = 1
      -- Align settings automatically
      vim.g.terraform_align = 1
    end,
  },
  
  -- Treesitter support for HCL and Terraform
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
      end
    end,
  },
}