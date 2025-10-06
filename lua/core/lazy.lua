--nvim/lua/core/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins"},
    { import = "passiveplugins"},
    { import = "extras/dap"},
    { import = "extras/lang/c"},
    { import = "extras/lang/md"},
    --{ import = "extras/ai"},
  },
  defaults = {
    lazy = false,
  },
})
