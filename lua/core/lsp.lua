-- ~/.config/nvim/lua/core/lsp.lua
local M = {}

function M.setup()
  -- 纯粹、直接地加载每个服务器的配置文件
  -- 每个 lsp/xxx.lua 文件都是自执行模块，require 即完成配置
  require("lsp.clangd")
  require("lsp.rust_analyzer")
  require("lsp.pyright")
  require("lsp.marksman")
  require("lsp.lua_ls")
  -- 一行对应一个服务器，清晰明了
end

return M
