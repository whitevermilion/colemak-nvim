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
  
  -- 新增: Visual 模式下的精确跳转功能
  -- 获取视觉模式下选中的文本并查找引用
  map("v", "gr", function()
    -- 保存视觉模式选择的起始和结束位置
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    
    -- 获取选中的文本
    local selected_text = vim.fn.getline(start_pos[1], end_pos[1])
    if #selected_text == 0 then return end
    
    -- 处理多行选择，取第一行（通常符号不会跨行）
    if #selected_text > 1 then
      selected_text = selected_text[1]
    end
    
    -- 提取选中的确切文本（考虑列位置）
    local start_col = start_pos[2]
    local end_col = end_pos[2] + 1 -- ">" mark 指向最后一个字符
    selected_text = string.sub(selected_text, start_col + 1, end_col)
    
    -- 使用选中的文本作为查询条件查找引用
    vim.lsp.buf.references({ context = { includeDeclaration = true } })
  end, "查找选中内容的引用")

  -- 可选: 为其他LSP功能也添加Visual模式支持
  map("v", "gd", function()
    vim.lsp.buf.definition()
  end, "跳转到选中内容的定义")
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
        require("lspconfig")[server].setup { 
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities() -- 如果你使用nvim-cmp
        }
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
