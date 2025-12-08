-- ~/.config/nvim/lsp/pyright.lua
local lspconfig = require("lspconfig")

if not lspconfig.pyright then
  vim.notify("lspconfig: pyright config not found!", vim.log.levels.ERROR)
  return
end

lspconfig.pyright.setup({
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  -- 注意：原 on_attach 中的自定义命令已移除，将在 after/ftplugin/python.lua 中处理
})
