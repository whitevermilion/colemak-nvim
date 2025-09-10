return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost" },
    config = function()
      local lint = require("lint")
      
      -- 1. 先注册自定义 linters
      -- 注册 clang_tidy linter (使用下划线命名)
      lint.linters.clang_tidy = {
        cmd = "clang-tidy",
        args = {
          "--quiet",
          "--checks=*,-llvmlibc-restrict-system-libc-headers"
        },
        condition = function(ctx)
          -- 只在项目中有 .clang-tidy 文件时启用
          return vim.fs.find(".clang-tidy", { path = ctx.filename, upward = true })[1]
        end,
        -- 添加输出解析器
        parser = require("lint.parser").from_errorformat(
          "%f:%l:%c: %t%*[^:]: %m",
          { source = "clang-tidy" }
        )
      }
      
      -- 注册 flake8 linter
      lint.linters.flake8 = {
        cmd = "flake8",
        args = {
          "--max-line-length=88",  -- 与 Black 格式化器一致
          "--ignore=E203,W503"    -- 忽略与 Black 冲突的规则
        },
        parser = require("lint.parser").from_errorformat(
          "%f:%l:%c: %t%*[^ ] %m",
          { source = "flake8" }
        )
      }
      
      -- 2. 设置文件类型映射
      lint.linters_by_ft = {
        c = { "clang_tidy" },      -- 使用新注册的名称
        cpp = { "clang_tidy" },    -- 使用新注册的名称
        python = { "flake8" },
      }
      
      -- 创建防抖函数 (150ms)
      local debounce = function(ms, fn)
        local timer = vim.uv.new_timer()
        return function()
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule(fn)
          end)
        end
      end
      
      -- Lint 当前缓冲区
      local lint_buffer = debounce(150, function()
        lint.try_lint()
      end)
      
      -- 注册自动命令
      vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost"}, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = lint_buffer
      })

    end
  }
}
