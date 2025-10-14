-- lua/extras/lang/c/lsp_c_clangd.lua
return {
  {
    "neovim/nvim-lspconfig",
    ft = { "c", "objc" }, -- 只处理 C 语言相关文件
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 从 passiveplugins.lsp_base 导入 on_attach 函数
      local on_attach = require("passiveplugins.lsp_base").on_attach

      lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
        },
        filetypes = { "c", "objc" }, -- 只处理 C 语言
        single_file_support = true,
      })
    end,
  },
}
