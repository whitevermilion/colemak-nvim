return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        python = { "black", "isort" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "jq" },
        markdown = { "prettier" },
      },

      -- 格式化器配置
      formatters = {
        stylua = {
          args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
        },
      },
    })

    -- 自动格式化（在保存时）
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        -- 检查当前文件类型是否有配置的格式化器
        local formatters = conform.formatters_by_ft[ft]
        local has_formatter = formatters ~= nil

        -- 如果有对应的格式化器，则执行格式化
        if has_formatter then
          conform.format({
            bufnr = buf,
            timeout_ms = 3000,
            async = false,
            quiet = true,
          })
        end
      end,
    })
  end,
}
