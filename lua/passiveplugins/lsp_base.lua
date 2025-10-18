-- lua/passiveplugins/lsp_base.lua
-- 合并了 lspconfig、mason 和 mason-lspconfig的配置
local M = {}

-- 简化的 on_attach 函数 - 移除了所有快捷键
M.on_attach = function(_, bufnr)
  -- 现在为空，以后有需要时可以添加自定义功能
  -- 保留这个函数是为了保持 LSP 服务器的正常附加
end

-- 配置诊断虚拟文本
local function setup_diagnostics()
  vim.diagnostic.config({
    virtual_text = {
      source = "if_many", -- 只在有多个诊断时显示源
      prefix = "●", -- 诊断前缀符号
    },
    signs = true, -- 显示行号旁边的标记
    underline = true, -- 在问题代码下显示下划线
    update_in_insert = false, -- 不在插入模式更新诊断
    severity_sort = true, -- 按严重程度排序
  })

  -- 自定义诊断符号
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- 定义所有服务器配置
local function setup_servers()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local on_attach = M.on_attach

  -- 基础服务器配置（使用默认设置）
  local base_servers = { "lua_ls", "pyright", "bashls", "jsonls", "yamlls" }

  for _, server in ipairs(base_servers) do
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- C/C++ 特殊配置
  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=never",
      "--completion-style=detailed",
      "--query-driver=/usr/bin/g++,/usr/bin/clang++,/usr/bin/gcc,/usr/bin/clang",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    single_file_support = true,
  })

  -- 可以根据需要添加其他语言的特殊配置
  -- 例如 Rust、Go、TypeScript 等
end

-- Mason 确保安装的包
local mason_packages = {
  -- LSP 服务器
  "lua_ls",
  "pyright",
  "clangd",
  "bashls",
  "jsonls",
  "yamlls",

  -- 格式化工具
  "black",
  "isort",
  "clang-format",
  "stylua",
  "prettierd",
  "prettier",
  "jq",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 设置诊断配置
      setup_diagnostics()

      -- 设置所有 LSP 服务器
      setup_servers()
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
        ensure_installed = mason_packages,
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "bashls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = true,
      })
    end,
  },
}
