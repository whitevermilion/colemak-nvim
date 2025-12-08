-- ~/.config/nvim/lsp/rust_analyzer.lua
local lspconfig = require("lspconfig")

if not lspconfig.rust_analyzer then
  vim.notify("lspconfig: rust_analyzer config not found!", vim.log.levels.ERROR)
  return
end

lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})
