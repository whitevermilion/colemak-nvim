-- nvim/lua/passiveplugins/lsp_conform.lua
return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        markdown = { "prettier", "injected" }, -- 只为 markdown 启用注入
        html = { "prettier" },
        htm = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        lua = { "stylua" },
      },

      formatters = {
        prettier = {
          command = "prettier",
          args = function(self, ctx)
            -- 根据文件扩展名确定解析器
            local ext = vim.fn.fnamemodify(ctx.filename or "", ":e")
            local parser

            if ext == "html" or ext == "htm" then
              parser = "html"
            elseif ext == "css" then
              parser = "css"
            elseif ext == "md" or ext == "markdown" then
              parser = "markdown"
            elseif ext == "js" or ext == "javascript" then
              parser = "babel"
            else
              parser = "html" -- 默认使用 html 解析器
            end

            return {
              "--stdin-filepath",
              ctx.filename or "unknown.html",
              "--parser",
              parser,
              "--tab-width",
              "2",
              "--use-tabs",
              "false",
              "--print-width",
              "80",
              "--html-whitespace-sensitivity",
              "css",
              "--end-of-line",
              "lf",
            }
          end,
        },
        stylua = {
          command = "stylua",
          args = { "-" }, -- 使用默认配置
        },
        clang_format = {
          command = "clang-format",
          args = { "--style={BasedOnStyle: Google, UseTab: false, IndentWidth: 4, TabWidth: 4}" },
        },
      },
    })

    -- 为 markdown 配置注入的格式化器
    require("conform").formatters.injected = {
      options = {
        lang_to_formatters = {
          lua = { "stylua" },
          python = { "black" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          html = { "prettier" },
          css = { "prettier" },
          javascript = { "prettier" },
        },
      },
    }

    -- 自动格式化
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        if bufname ~= "" then
          conform.format({
            bufnr = args.buf,
            timeout_ms = 5000,
            async = false,
          })
        end
      end,
    })
  end,
}
