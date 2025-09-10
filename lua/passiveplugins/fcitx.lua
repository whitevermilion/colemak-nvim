-- ~/.config/nvim/lua/plugins/fcitx.lua
return {
  "lilydjwg/fcitx.vim",
  event = "InsertEnter",
  init = function()
    -- 核心设置 (无任何额外功能)
    vim.g.fcitx5_remote = '/usr/bin/fcitx5-remote'  -- 确保路径正确
    vim.g.fcitx_default_im = 0  -- 强制退出插入模式时使用英文
    
    -- 关键性能优化
    vim.opt.ttimeoutlen = 50  -- 减少切换延迟
  end,
  config = function()
    -- 完全禁用所有额外功能
    vim.g.fcitx_no_default_key = 1    -- 禁用默认快捷键
    vim.g.fcitx_no_auto = 0           -- 确保自动切换启用
  end
}
