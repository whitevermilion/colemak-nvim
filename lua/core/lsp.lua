-- ~/.config/nvim/lua/core/lsp.lua
local M = {}

function M.setup()
  vim.lsp.enable("clangd")
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("marksman")
  vim.lsp.enable("pyright")
  vim.lsp.enable("rust_analyzer")

  -- 启用诊断虚拟文本
  vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = true,
  })

  -- 启用内联提示（如果可用）
  if vim.lsp.inlay_hint then vim.lsp.inlay_hint.enable(true) end
end

return M
