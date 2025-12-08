-- ~/.config/nvim/lsp/clangd.lua
local lspconfig = require("lspconfig")

if not lspconfig.clangd then
  vim.notify("lspconfig: clangd config not found!", vim.log.levels.ERROR)
  return
end

lspconfig.clangd.setup({
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
  },
  single_file_support = true,
})
