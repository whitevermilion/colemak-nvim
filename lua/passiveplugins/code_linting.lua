return {
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      local lint = require("lint")

      -- C/C++ - 使用 clang-tidy（简化为只检查语法错误）
      lint.linters.clang_tidy = {
        cmd = "clang-tidy",
        args = {
          "--quiet",
          "--checks=-*,clang-diagnostic-*",
        },
        stdin = false,
        stream = "stderr",
        ignore_exitcode = true,
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %m"),
      }

      -- Python - 使用 flake8（使用更简单的格式）
      lint.linters.flake8 = {
        cmd = "flake8",
        stdin = true,
        args = {},
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %m"),
      }

      -- Rust - 简化 clippy 配置
      lint.linters.clippy = {
        cmd = "cargo",
        args = { "clippy", "--quiet", "--", "-D", "warnings" },
        stdin = false,
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.parser").from_errorformat(
          [[%Eerror[%n]: %m]],
          [[%Wwarning[%n]: %m]],
          [[%Iinfo[%n]: %m]]
        ),
      }

      -- 文件类型映射（只保留必要的）
      lint.linters_by_ft = {
        c = { "clang_tidy" },
        cpp = { "clang_tidy" },
        python = { "flake8" },
        rust = { "clippy" },
      }

      -- 手动触发 lint
      vim.api.nvim_create_user_command("Lint", function() lint.try_lint() end, { desc = "运行代码检查" })

      -- 保存时自动检查（简化）
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function() vim.defer_fn(lint.try_lint, 100) end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Toggle quickfix" },
    },
  },
}
