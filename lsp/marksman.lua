-- ~/.config/nvim/lsp/marksman.lua
local lspconfig = require("lspconfig")

if not lspconfig.marksman then
  vim.notify("lspconfig: marksman config not found!", vim.log.levels.ERROR)
  return
end

lspconfig.marksman.setup({
  cmd = { "marksman", "server" },
  root_markers = { ".marksman.toml", ".git" },
  filetypes = { "markdown", "markdown.mdx" },
  single_file_support = true,
})
