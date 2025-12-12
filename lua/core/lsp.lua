-- ~/.config/nvim/lua/core/lsp.lua
local M = {}

function M.setup()
  require("lsp.clangd")
  require("lsp.rust_analyzer")
  require("lsp.pyright")
  require("lsp.marksman")
  require("lsp.lua_ls")
end

return M
