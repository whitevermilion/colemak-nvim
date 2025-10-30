-- nvim/lua/core/basic.lua
-- 基本设置
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
vim.o.scrolloff = 8 -- 光标移动时保留上下文行数（保留你的设置）
vim.o.sidescrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.splitbelow = true
vim.o.splitright = true

--换行
vim.opt.wrap = true -- 启用视觉换行（软换行）
vim.opt.linebreak = true -- 只在单词边界处换行，避免单词被截断
vim.opt.breakindent = true -- 换行后保持缩进，提升可读性
vim.opt.showbreak = "↳ " -- 在折行前显示一个箭头符号（可选）

-- 缩进与编辑
vim.opt.expandtab = true
vim.opt.tabstop = 4 -- 保留你的 tab 设置
vim.opt.shiftwidth = 0 -- 保留你的缩进设置
vim.opt.smartindent = true -- 新增：智能缩进
vim.o.shiftround = true -- 新增：缩进对齐到 shiftwidth 倍数

-- 剪贴板与文件处理
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- 改进：SSH 兼容
vim.opt.autowrite = true -- 新增：自动保存修改
vim.opt.undofile = true -- 新增：持久化撤销历史
vim.opt.undolevels = 10000 -- 新增：增大撤销历史
vim.opt.confirm = true -- 新增：退出未保存时确认

-- 搜索与替换
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit" -- 新增：实时替换预览

-- UI 增强
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.background = "dark"
vim.wo.signcolumn = "yes"
vim.opt.pumblend = 10
vim.opt.pumheight = 5
vim.opt.splitkeep = "screen"
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.api.nvim_set_hl(0, "Cursor", { fg = "#FFFFFF", bg = "#FFFFFF" })

-- 性能优化
vim.opt.updatetime = 200 -- 新增：减少 CursorHold 延迟
vim.o.timeoutlen = 500 -- 保留你的设置

-- 高级功能
vim.opt.list = true -- 新增：显示不可见字符
vim.opt.virtualedit = "block" -- 新增：虚拟编辑模式
vim.opt.wildmode = "longest:full,full" -- 新增：命令行补全增强

-- 折叠设置 (Neovim 0.10+ 优化)
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
  vim.opt.foldlevel = 99
else
  vim.opt.foldmethod = "indent"
  vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- LazyVim 全局设置 (按需添加)
vim.g.autoformat = true -- 自动格式化
vim.g.snacks_animate = true -- 动画效果
vim.g.trouble_lualine = true -- Trouble 集成
vim.g.markdown_recommended_style = 0 -- Markdown 缩进修复

-- 使用fish作为默认终端
vim.opt.shell = "fish"
