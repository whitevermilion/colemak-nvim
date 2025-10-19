--nvim/lua/core/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "passiveplugins" },
    { import = "extras/extras_list" },
    -- { import = "extras/dap" },
    -- { import = "extras/lang/c" },
    -- { import = "extras/lang/cpp" },
    -- { import = "extras/lang/lua" },
    -- { import = "extras/lang/python" },
    -- { import = "extras/lang/md" },
    -- { import = "extras/ai" },
  },
  defaults = {
    lazy = false,
  },
  ui = {
    border = "rounded",
  },
})

require("extras.manager").setup()
require("lua_function.poetry").setup()
require("lua_function.todo_list_remainder").setup()
require("lua_function.time_count").setup()
