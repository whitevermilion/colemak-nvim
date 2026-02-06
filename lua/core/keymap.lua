-- nvim/lua/core/keymap.lua

-- ===================== 基础设置 =====================
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local set = vim.keymap.set

-- ===================== 基础导航 =====================

-- 单词移动映射
set("n", "j", "e", { noremap = true, silent = true })
set("n", "J", "E", { noremap = true, silent = true })

-- ===================== 窗口管理 =====================
-- 窗口大小调整
map("n", "<C-e>", "<cmd>resize +2<cr>", opt)
map("n", "<C-n>", "<cmd>resize -2<cr>", opt)
map("n", "<C-i>", "<cmd>vertical resize -2<cr>", opt)
map("n", "<C-h>", "<cmd>vertical resize +2<cr>", opt)

-- Colemak 方向键映射 (hnei 对应 hjkl)
set("n", "n", "j", { noremap = true, silent = true, desc = "向下移动" })
set("n", "e", "k", { noremap = true, silent = true, desc = "向上移动" })
set("n", "h", "h", { noremap = true, silent = true, desc = "向左移动" })
set("n", "i", "l", { noremap = true, silent = true, desc = "向右移动" })
set("n", "I", "L", { noremap = true, silent = true })

-- 窗口间导航 (Alt + 方向)
map("n", "<A-h>", "<C-w>h", opt) -- 向左移动窗口焦点
map("n", "<A-n>", "<C-w>j", opt) -- 向下移动窗口焦点
map("n", "<A-e>", "<C-w>k", opt) -- 向上移动窗口焦点
map("n", "<A-i>", "<C-w>l", opt) -- 向右移动窗口焦点

-- 滚动控制
set("n", "N", "<C-e>", { noremap = true, silent = true, desc = "向下滚动一行" })
set("n", "E", "<C-y>", { noremap = true, silent = true, desc = "向上滚动一行" })

-- 分屏管理 (<leader>s 前缀)
set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "[S]plit [V]ertical 垂直分屏" })
set("n", "<leader>sh", "<cmd>split<cr>", { desc = "[S]plit [H]orizontal 水平分屏" })
set("n", "<leader>sx", "<cmd>wincmd x<cr>", { desc = "[S]plit e[X]change 交换窗口" })

-- ===================== 编辑操作 =====================
-- Visual 模式操作
map("v", "<", "<gv", opt) -- 向左缩进
map("v", ">", ">gv", opt) -- 向右缩进
map("v", "N", ":move '>+1<CR>gv-gv", opt) -- 向下移动选中文本
map("v", "E", ":move '<-2<CR>gv-gv", opt) -- 向上移动选中文本

-- ===================== Colemak 键盘布局 =====================
-- 插入模式映射
set("n", "u", "i", { noremap = true, silent = true, desc = "插入模式" })
set("n", "U", "I", { noremap = true, silent = true, desc = "行首插入" })

-- 搜索功能映射
set("n", "k", "n", { noremap = true, silent = true, desc = "搜索下一个匹配项" })
set("n", "K", "N", { noremap = true, silent = true, desc = "搜索上一个匹配项" })

-- Visual 模式方向键（Colemak 布局）
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
  vim.cmd("write")
  vim.cmd("Dashboard")
end, {})

-- Markdown 标题级别提升（#数量减少）
vim.api.nvim_create_user_command("Mdtitleup", function(o)
  vim.cmd(o.line1 .. "," .. o.line2 .. "s/^\\(#\\+\\)#\\s/\\1 /g")
  vim.notify("📈 标题级别已提升", vim.log.levels.INFO)
end, { range = true })

-- Markdown 标题级别降低（#数量增加）
vim.api.nvim_create_user_command("Mdtitledown", function(o)
  vim.cmd(o.line1 .. "," .. o.line2 .. "s/^\\(#\\+\\)\\s/\\1# /g")
  vim.notify("📉 标题级别已降低", vim.log.levels.INFO)
end, { range = true })
