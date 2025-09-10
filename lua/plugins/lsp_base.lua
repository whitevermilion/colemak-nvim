-- lsp-base.lua
-- 合并了 lspconfig、mason 和 mason-lspconfig 的配置
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- 文件事件触发加载
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      ------------------------------------------------------------------
      -- 统一按键绑定：跳转、重命名、悬停、代码动作
      ------------------------------------------------------------------
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- 跳转相关
        map("n", "gd", vim.lsp.buf.definition,  "跳到定义")
        map("n", "gD", vim.lsp.buf.declaration, "跳到声明")
        map("n", "gi", vim.lsp.buf.implementation, "跳到实现")
        map("n", "gr", vim.lsp.buf.references,  "查找引用")
      end

      -- 配置 LSP 服务器，并挂接按键
      require("lspconfig").lua_ls.setup { on_attach = on_attach }
      require("lspconfig").clangd.setup { on_attach = on_attach }
      -- 如需更多服务器，继续在此添加：
      -- require("lspconfig").pyright.setup { on_attach = on_attach }
    end
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- 自动更新工具列表
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending   = "➜",
            package_uninstalled = "✗"
          }
        },
        -- 统一安装所有工具
        ensure_installed = {
          -- LSP 服务器
          "lua_ls",
          "pyright",
          "clangd",
          -- 格式化工具
          "black",
          "isort",
          "clang-format",
          "stylua",
          "prettierd",
          "prettier",
          "jq",
        }
      }
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          -- 在此添加更多需要自动安装的 LSP
        },
        automatic_installation = true
      }
    end
  }
}
