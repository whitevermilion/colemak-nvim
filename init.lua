-- init.lua
require("core.basic")
require("core.amendments")
require("core.keymap")
require("core.lazy")
require("core.autocmd")
require("core.neovide")

-- require("core.lsp").setup()
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")

--剪切板
vim.opt.clipboard = "unnamedplus"
