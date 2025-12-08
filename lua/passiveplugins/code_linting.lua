return {
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      local lint = require("lint")

      -- C/C++（保持原样）
      lint.linters.clang_tidy = {
        cmd = "clang-tidy",
        args = { "--quiet" },
      }

      -- Python（保持原样）
      lint.linters.flake8 = {
        cmd = "flake8",
        args = { "--max-line-length=88" },
      }

      -- Rust：一行搞定！
      lint.linters.rustc = {
        cmd = "rustc",
        args = { "--edition", "2021" }, -- 只用这一个参数
      }

      -- 文件类型映射
      lint.linters_by_ft = {
        c = { "clang_tidy" },
        cpp = { "clang_tidy" },
        python = { "flake8" },
        rust = { "rustc" }, -- 就改这一行
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function() lint.try_lint() end,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "诊断" },
    },
  },
}
