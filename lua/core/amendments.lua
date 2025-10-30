-- nvim/lua/core/amendments.lua
-- amendments.lua - 误触修正专用配置文件
-- 专注解决各种误触问题，保持配置整洁

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- ==================== 禁用易误触键位 ====================

-- 禁用 J 键（经常误触）
map("n", "J", "<Nop>", opt)
map("v", "J", "<Nop>", opt)

-- 禁用 Q 键（容易误入 Ex 模式）
map("n", "Q", "<Nop>", opt)

-- 修正常见的命令拼写错误
vim.cmd([[
  command! W w
  command! Wq wq
  command! WQ wq
  command! Q q
  command! Qa qa
  command! QA qa
  command! Wqa wqa
  command! WQa wqa
  command! WQA wqa
]])
