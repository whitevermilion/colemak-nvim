-- nvim/lua/core/keymap.lua
-- ===================== 基础设置 =====================
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local set = vim.keymap.set

-- ===================== 基础导航 =====================
-- 禁用 J 键，防止误触
map("n", "J", "<Nop>", opt)

-- ===================== 窗口管理 =====================
-- 窗口调整（方向键）
map("n", "<C-Up>", "<cmd>resize +2<cr>", opt)
map("n", "<C-Down>", "<cmd>resize -2<cr>", opt)
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opt)
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opt)

-- 滚动控制
map("n", "<C-n>", "<C-e>", opt) -- 向下滚动
map("n", "<C-e>", "<C-y>", opt) -- 向上滚动

-- 分屏管理 (<leader>s 前缀)
set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "[S]plit [V]ertical 垂直分屏" })
set("n", "<leader>sh", "<cmd>split<cr>", { desc = "[S]plit [H]orizontal 水平分屏" })
set("n", "<leader>sx", "<cmd>wincmd x<cr>", { desc = "[S]plit e[X]change 交换窗口" })

-- ===================== 编辑操作 =====================
-- Visual 模式操作
map("v", "<", "<gv", opt) -- 向左缩进
map("v", ">", ">gv", opt) -- 向右缩进
map("v", "J", ":move '>+1<CR>gv-gv", opt) -- 向下移动选中文本
map("v", "K", ":move '<-2<CR>gv-gv", opt) -- 向上移动选中文本

-- ===================== Colemak 键盘布局 =====================
-- 核心方向键映射 (hnei 作为上下左右)
set("n", "h", "h", { noremap = true, silent = true, desc = "向左移动" })
set("n", "n", "j", { noremap = true, silent = true, desc = "向下移动" })
set("n", "e", "k", { noremap = true, silent = true, desc = "向上移动" })
set("n", "i", "l", { noremap = true, silent = true, desc = "向右移动" })

-- 窗口导航 - Colemak 专用
map("n", "<A-h>", "<C-w>h", opt) -- 向左移动窗口焦点
map("n", "<A-n>", "<C-w>j", opt) -- 向下移动窗口焦点
map("n", "<A-e>", "<C-w>k", opt) -- 向上移动窗口焦点
map("n", "<A-i>", "<C-w>l", opt) -- 向右移动窗口焦点

-- 插入模式映射
set("n", "u", "i", { noremap = true, silent = true, desc = "插入模式" })
set("n", "U", "I", { noremap = true, silent = true, desc = "行首插入" })

-- 搜索功能映射
set("n", "k", "n", { noremap = true, silent = true, desc = "搜索下一个匹配项" })
set("n", "K", "N", { noremap = true, silent = true, desc = "搜索上一个匹配项" })

-- Visual 模式方向键
set("v", "h", "h", { noremap = true, silent = true })
set("v", "n", "j", { noremap = true, silent = true })
set("v", "e", "k", { noremap = true, silent = true })
set("v", "i", "l", { noremap = true, silent = true })

-- 撤销/重做映射
set("n", "l", "u", { noremap = true, silent = true, desc = "撤销" })
set("n", "L", "<C-r>", { noremap = true, silent = true, desc = "重做" })

-- ===================== 自定义命令 =====================

-- 保存并返回 Dashboard
vim.api.nvim_create_user_command("WQ", function()
  vim.cmd("write") -- 保存当前文件
  vim.cmd("Dashboard") -- 返回 Dashboard
end, {})

-- 提升标题级别（#数量减少）
vim.api.nvim_create_user_command("Mdtitleup", function(o)
  vim.cmd(o.line1 .. "," .. o.line2 .. "s/^\\(#\\+\\)#\\s/\\1 /g")
  vim.notify("📈 标题级别已提升", vim.log.levels.INFO)
end, { range = true })

-- 降低标题级别（#数量增加）
vim.api.nvim_create_user_command("Mdtitledown", function(o)
  vim.cmd(o.line1 .. "," .. o.line2 .. "s/^\\(#\\+\\)\\s/\\1# /g")
  vim.notify("📉 标题级别已降低", vim.log.levels.INFO)
end, { range = true })
