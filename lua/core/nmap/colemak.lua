local set = vim.keymap.set
-- Colemak 方向键映射 (hnei 对应 hjkl)
set("n", "n", "j", { noremap = true, silent = true, desc = "向下移动" })
set("n", "e", "k", { noremap = true, silent = true, desc = "向上移动" })
set("n", "h", "h", { noremap = true, silent = true, desc = "向左移动" })
set("n", "i", "l", { noremap = true, silent = true, desc = "向右移动" })
set("n", "I", "L", { noremap = true, silent = true })

-- 窗口间导航 (Alt + 方向)
set("n", "<A-h>", "<C-w>h", opt) -- 向左移动窗口焦点
set("n", "<A-n>", "<C-w>j", opt) -- 向下移动窗口焦点
set("n", "<A-e>", "<C-w>k", opt) -- 向上移动窗口焦点
set("n", "<A-i>", "<C-w>l", opt) -- 向右移动窗口焦点

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
