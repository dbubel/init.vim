return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        bmap("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next git hunk")
        bmap("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev git hunk")

        -- Actions
        bmap("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
        bmap("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
        bmap("v", "<leader>ghs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk")
        bmap("v", "<leader>ghr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected hunk")
        bmap("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
        bmap("n", "<leader>ghb", gs.blame_line, "Blame line")
        bmap("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle inline blame")
        bmap("n", "<leader>gd", gs.diffthis, "Diff against index")

        -- Hunk textobject
        bmap({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
      end,
    },
  },
}
