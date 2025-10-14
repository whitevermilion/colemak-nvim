-- lsp-base.lua
-- 合并了 lspconfig、mason 和 mason-lspconfig的配置

local M = {}

-- 导出 on_attach 函数供其他文件使用
M.on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- 跳转相关
  map("n", "gd", vim.lsp.buf.definition, "跳到定义")
  map("n", "gD", vim.lsp.buf.declaration, "跳到声明")
  map("n", "gi", vim.lsp.buf.implementation, "跳到实现")
  map("n", "gr", vim.lsp.buf.references, "查找引用")

  -- Visual模式下的精确跳转功能
  map("v", "gr", function()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    local selected_text = vim.fn.getline(start_pos[1], end_pos[1])
    if #selected_text == 0 then
      return
    end
    if #selected_text > 1 then
      selected_text = selected_text[1]
    end
    local start_col = start_pos[2]
    local end_col = end_pos[2] + 1
    selected_text = string.sub(selected_text, start_col + 1, end_col)
    vim.lsp.buf.references({ context = { includeDeclaration = true } })
  end, "查找选中内容的引用")

  map("v", "gd", function()
    vim.lsp.buf.definition()
  end, "跳转到选中内容的定义")
end

-- 配置诊断虚拟文本
local function setup_diagnostics()
  vim.diagnostic.config({
    virtual_text = {
      source = "if_many", -- 只在有多个诊断时显示源
      prefix = "●", -- 诊断前缀符号
      -- prefix = "",     -- 或者使用 Nerd Font 图标
    },
    signs = true, -- 显示行号旁边的标记
    underline = true, -- 在问题代码下显示下划线
    update_in_insert = false, -- 不在插入模式更新诊断
    severity_sort = true, -- 按严重程度排序
  })

  -- 可选：自定义诊断符号
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- 定义服务器列表（移除clangd）
local servers = { "lua_ls", "pyright" }

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 设置诊断配置
      setup_diagnostics()

      -- 自动设置所有服务器（不包括clangd）
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup({
          on_attach = M.on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        ensure_installed = {
          -- LSP服务器（移除clangd）
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
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers, -- 移除clangd
        automatic_installation = true,
      })
    end,
  },
}
