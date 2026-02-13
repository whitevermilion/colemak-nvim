-- nvim/lua/core/keymap.lua
require("core.nmap.command_mode")
require("core.nmap.colemak")
-- ===================== 基础设置 =====================
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local set = vim.keymap.set

-- ===================== 基础导航 =====================

-- 单词移动映射
set("n", "j", "e", { noremap = true, silent = true, desc = "向前移动到单词末尾" })
set("n", "J", "E", { noremap = true, silent = true, desc = "向前移动到单词末尾（大写）" })

-- ===================== 窗口管理 =====================
-- 窗口大小调整
set("n", "<C-e>", "<cmd>resize +2<cr>", { noremap = true, silent = true, desc = "增加窗口高度" })
set("n", "<C-n>", "<cmd>resize -2<cr>", { noremap = true, silent = true, desc = "减少窗口高度" })
set("n", "<C-h>", "<cmd>vertical resize -2<cr>", { noremap = true, silent = true, desc = "减少窗口宽度" })
set("n", "<C-i>", "<cmd>vertical resize +2<cr>", { noremap = true, silent = true, desc = "增加窗口宽度" })

-- Colemak 方向键映射 (hnei 对应 hjkl)
set("n", "n", "j", { noremap = true, silent = true, desc = "向下移动" })
set("n", "e", "k", { noremap = true, silent = true, desc = "向上移动" })
set("n", "h", "h", { noremap = true, silent = true, desc = "向左移动" })
set("n", "i", "l", { noremap = true, silent = true, desc = "向右移动" })
set("n", "I", "L", { noremap = true, silent = true, desc = "向右移动到行尾" })

-- 窗口间导航 (Alt + 方向)
set("n", "<A-h>", "<C-w>h", { noremap = true, silent = true, desc = "切换到左侧窗口" })
set("n", "<A-n>", "<C-w>j", { noremap = true, silent = true, desc = "切换到下方窗口" })
set("n", "<A-e>", "<C-w>k", { noremap = true, silent = true, desc = "切换到上方窗口" })
set("n", "<A-i>", "<C-w>l", { noremap = true, silent = true, desc = "切换到右侧窗口" })

-- 滚动控制
set("n", "N", "<C-e>", { noremap = true, silent = true, desc = "向下滚动一行" })
set("n", "E", "<C-y>", { noremap = true, silent = true, desc = "向上滚动一行" })

-- 分屏管理 (<leader>s 前缀)
set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "[S]plit [V]ertical 垂直分屏" })
set("n", "<leader>sh", "<cmd>split<cr>", { desc = "[S]plit [H]orizontal 水平分屏" })
set("n", "<leader>sx", "<cmd>wincmd x<cr>", { desc = "[S]plit e[X]change 交换窗口" })

-- ===================== 编辑操作 =====================
-- Visual 模式操作
set("v", "<", "<gv", { noremap = true, silent = true, desc = "向左缩进并保持选中" })
set("v", ">", ">gv", { noremap = true, silent = true, desc = "向右缩进并保持选中" })
set("v", "N", ":move '>+1<CR>gv-gv", { noremap = true, silent = true, desc = "向下移动选中文本" })
set("v", "E", ":move '<-2<CR>gv-gv", { noremap = true, silent = true, desc = "向上移动选中文本" })

-- ===================== Colemak 键盘布局 =====================
-- 插入模式映射
set("n", "u", "i", { noremap = true, silent = true, desc = "插入模式" })
set("n", "U", "I", { noremap = true, silent = true, desc = "行首插入" })

-- 搜索功能映射
set("n", "k", "n", { noremap = true, silent = true, desc = "搜索下一个匹配项" })
set("n", "K", "N", { noremap = true, silent = true, desc = "搜索上一个匹配项" })

-- Visual 模式方向键（Colemak 布局）
set("v", "h", "h", { noremap = true, silent = true, desc = "向左移动（Visual）" })
set("v", "n", "j", { noremap = true, silent = true, desc = "向下移动（Visual）" })
set("v", "e", "k", { noremap = true, silent = true, desc = "向上移动（Visual）" })
set("v", "i", "l", { noremap = true, silent = true, desc = "向右移动（Visual）" })

-- 撤销/重做映射
set("n", "l", "u", { noremap = true, silent = true, desc = "撤销" })
set("n", "L", "<C-r>", { noremap = true, silent = true, desc = "重做" })
