-- ~/.config/nvim/lua/core/lsp.lua
local M = {}

function M.setup()
  vim.lsp.enable("clangd")
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("marksman")
  vim.lsp.enable("pyright")
  vim.lsp.enable("rust_analyzer")
end

return M
