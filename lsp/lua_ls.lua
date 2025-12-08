-- ~/.config/nvim/lsp/lua_ls.lua
local lspconfig = require("lspconfig")

if not lspconfig.lua_ls then
  vim.notify("lspconfig: lua_ls config not found!", vim.log.levels.ERROR)
  return
end

lspconfig.lua_ls.setup({
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
})
