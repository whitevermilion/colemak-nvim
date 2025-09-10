-- 保留你的核心设置
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

-- 窗口导航
map("n","<A-h>","<C-w>h",opt)
map("n","<A-j>","<C-w>j",opt)
map("n","<A-k>","<C-w>k",opt)
map("n","<A-l>","<C-w>l",opt)

-- 窗口调整
map("n", "<C-Up>", "<cmd>resize +2<cr>", opt)
map("n", "<C-Down>", "<cmd>resize -2<cr>", opt)
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opt)
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opt)

map("n", "<C-j>", "<C-e>", opt)
map("n", "<C-k>", "<C-y>", opt)

-- 禁用 J 键,防止误触
map("n", "J", "<Nop>", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 撤销操作
vim.keymap.set("n","<C-z>","<Cmd>undo<CR>",{ silent = true})

-- 使用 vim.keymap.set 添加带描述的快捷键
local set = vim.keymap.set

-- 分屏管理 (前缀: <leader>s)
-- s: split 的缩写，统一分屏操作前缀
set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "[S]plit [V]ertical 垂直分屏" })
set("n", "<leader>sh", "<cmd>split<cr>",  { desc = "[S]plit [H]orizontal 水平分屏" })
set("n", "<leader>sc", "<C-w>c",         { desc = "[S]plit [C]lose 关闭当前窗口" })
set("n", "<leader>so", "<C-w>o",         { desc = "[S]plit [O]nly 仅保留当前窗口" })
set("n", "<leader>se", "<C-w>=",         { desc = "[S]plit [E]qualize 等分窗口尺寸" })

-- 窗口最大化切换 (LazyVim 特色功能)
set("n", "<leader>sm", function()
    local cur_win = vim.api.nvim_get_current_win()
    if vim.w.maximized and vim.w.maximized ~= cur_win then
        vim.cmd("wincmd =")  -- 重置布局
    end
    vim.cmd("wincmd _ | wincmd |")  -- 最大化当前窗口
    vim.w.maximized = vim.w.maximized == cur_win and nil or cur_win
end, { desc = "[S]plit [M]aximize Toggle 最大化/恢复窗口" })

-- 快速在分屏中打开文件
set("n", "<leader>sf", function()
    local file = vim.fn.input("Open file in split: ", "", "file")
    if file ~= "" then
        vim.cmd("split "..file)
    end
end, { desc = "[S]plit [F]ile 分屏打开文件" })

-- 创建自定义命令 :wQ 来保存并返回 Dashboard
vim.api.nvim_create_user_command('WQ', function()
    -- 保存当前文件
    vim.cmd('write')
    -- 返回 Dashboard
    vim.cmd('Dashboard')
end, {})

-- ===================== Colemak 专用键位映射 =====================
-- 核心方向键位映射（hnei 作为上下左右）
vim.keymap.set('n', 'h', 'h', { noremap = true, silent = true, desc = "向左移动" })
vim.keymap.set('n', 'n', 'j', { noremap = true, silent = true, desc = "向下移动" })
vim.keymap.set('n', 'e', 'k', { noremap = true, silent = true, desc = "向上移动" })
vim.keymap.set('n', 'i', 'l', { noremap = true, silent = true, desc = "向右移动" })

-- 插入模式映射（u 代替 i）
vim.keymap.set('n', 'u', 'i', { noremap = true, silent = true, desc = "插入模式" })
vim.keymap.set('n', 'U', 'I', { noremap = true, silent = true, desc = "行首插入" })

-- 设置 z 为撤销
vim.keymap.set({'n', 'v'}, 'z', 'u', { noremap = true, silent = true, desc = "撤销" })

-- 设置 k 和 K 代替 n 和 N 的搜索功能
vim.keymap.set('n', 'k', 'n', { noremap = true, silent = true, desc = "搜索下一个匹配项" })
vim.keymap.set('n', 'K', 'N', { noremap = true, silent = true, desc = "搜索上一个匹配项" })

-- 可视模式映射
vim.keymap.set('v', 'h', 'h', { noremap = true, silent = true })
vim.keymap.set('v', 'n', 'j', { noremap = true, silent = true })
vim.keymap.set('v', 'e', 'k', { noremap = true, silent = true })
vim.keymap.set('v', 'i', 'l', { noremap = true, silent = true })

-- 禁用原始方向键（jkl）防止误触
vim.keymap.set('n', 'j', '<Nop>', { noremap = true })
vim.keymap.set('n', 'l', '<Nop>', { noremap = true })
-- ===================== Colemak 映射结束 =====================
