-- lsp-base.lua
-- 合并了 lspconfig、mason 和 mason-lspconfig 的配置

-- 定义通用 on_attach 函数
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- 跳转相关
  map("n", "gd", vim.lsp.buf.definition, "跳到定义")
  map("n", "gD", vim.lsp.buf.declaration, "跳到声明")
  map("n", "gi", vim.lsp.buf.implementation, "跳到实现")
  map("n", "gr", vim.lsp.buf.references, "查找引用")
end

-- 定义服务器列表
local servers = { "lua_ls", "pyright", "clangd" }

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 自动设置所有服务器
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup { on_attach = on_attach }
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup {
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        ensure_installed = {
          -- LSP 服务器
          unpack(servers),
          -- 格式化工具
          "black",
          "isort",
          "clang-format",
          "stylua",
          "prettierd",
          "prettier",
          "jq",
        },
      }
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = servers,
        automatic_installation = true,
      }
    end,
  },
}
