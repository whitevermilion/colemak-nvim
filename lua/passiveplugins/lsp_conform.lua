return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- 为 Markdown 文件启用注入式格式化器
        markdown = { "injected" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        lua = { "stylua" },
        -- python = { "black", "isort" },
        -- javascript = { "prettier" },
        -- typescript = { "prettier" },
        -- html = { "prettier" },
        -- css = { "prettier" },
        -- json = { "jq" },
      },

      -- 添加格式化器配置
      formatters = {
        stylua = {
          args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
        },
        clang_format = {
          args = { "--style={BasedOnStyle: Google, UseTab: false, IndentWidth: 4, TabWidth: 4}" },
        },
      },
    })

    -- 为特定语言配置注入的格式化器
    require("conform").formatters.injected = {
      options = {
        lang_to_formatters = {
          lua = { "stylua" },
          python = { "black" },
          c = { "clang_format" },
          cpp = { "clang_format" },
        },
      },
    }

    -- 自动格式化（在保存时）
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        conform.format({
          bufnr = args.buf,
          timeout_ms = 3000,
          async = false,
        })
      end,
    })
  end,
}
