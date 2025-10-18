-- lua/extras/lang/cpp/lsp_cpp_clangd.lua
return {
  {
    "neovim/nvim-lspconfig",
    ft = { "cpp", "objcpp" },  -- 只处理 C++ 语言相关文件
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
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
          "--query-driver=/usr/bin/g++,/usr/bin/clang++",  -- 可选的：指定 C++ 编译器
        },
        filetypes = { "cpp", "objcpp" },  -- 只处理 C++ 语言
        single_file_support = true,
      })
    end
  }
}
