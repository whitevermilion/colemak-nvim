return {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      
      -- 配置格式化器（保持不变）
      conform.setup({
        formatters_by_ft = {
          python = { "black", "isort" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          h = { "clang_format" },
          hpp = { "clang_format" },
          lua = { "stylua" },
          javascript = { { "prettierd", "prettier" } },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "jq" },
          markdown = { "prettier" },
        },
        formatters = {
          black = {
            prepend_args = { "--line-length", "88" },
            condition = function(ctx)
              return vim.fs.find("pyproject.toml", { path = ctx.filename, upward = true })[1]
                     or vim.fs.find("requirements.txt", { path = ctx.filename, upward = true })[1]
            end
          },
          isort = {
            prepend_args = { "--profile", "black" } 
          },
          clang_format = {
            condition = function(ctx)
              return vim.fs.find(".clang-format", { path = ctx.filename, upward = true })[1]
            end,
            prepend_args = { "--style={BasedOnStyle: llvm, IndentWidth: 4, ColumnLimit: 100}" }
          },
          prettier = {
            condition = function(ctx)
              return vim.fs.find("package.json", { path = ctx.filename, upward = true })[1]
            end
          }
        }
      })

      -- 设置退出时自动格式化（添加大文件跳过）
      vim.api.nvim_create_autocmd("BufLeave", {
        pattern = { "*.py", "*.c", "*.cpp", "*.h", "*.hpp", "*.lua", "*.js", "*.ts", "*.html", "*.css", "*.json", "*.md" },
        callback = function(args)
          local buf = args.buf
          
          -- 跳过条件：只处理普通文件且已被修改
          if not (vim.bo[buf].modified and vim.bo[buf].buftype == "") then
            return
          end
          
          -- 跳过大型文件（行数 > 5000）
          local line_count = vim.api.nvim_buf_line_count(buf)
          if line_count > 5000 then
            vim.notify(
              string.format("跳过格式化: %s (文件过大: %d 行)", vim.fn.bufname(buf), line_count),
              vim.log.levels.WARN
            )
            return
          end
          
          -- 跳过二进制文件（如：图像、压缩文件）
         if vim.api.nvim_buf_get_option(buf, "binary") then
            vim.notify(
                string.format("跳过格式化: %s (二进制文件)", vim.fn.bufname(buf)),
            vim.log.levels.WARN
            )
            return
         end 
          
          -- 保存原始内容
          vim.cmd("silent! write")
          
          -- 执行格式化
          conform.format({
            bufnr = buf,
            timeout_ms = 3000,
            async = false,
            quiet = true,
            on_error = function(err)
              vim.notify("格式化失败: " .. err, vim.log.levels.ERROR)
            end
          })
          
          -- 格式化后重新保存
          vim.cmd("silent! write")
        end
      })
      
      -- 可选：添加手动格式化命令（跳过大型文件检查）
      vim.api.nvim_create_user_command("ForceFormat", function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].modified then
          vim.cmd("silent! write")
        end
        
        conform.format({
          bufnr = buf,
          timeout_ms = 10000, -- 延长大型文件的超时时间
          async = false,
          quiet = false,
          on_error = function(err)
            vim.notify("格式化失败: " .. err, vim.log.levels.ERROR)
          end
        })
        
        vim.cmd("silent! write")
      end, { desc = "强制格式化当前文件（跳过大小检查）" })
    end
}
