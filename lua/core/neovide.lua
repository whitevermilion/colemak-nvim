-- ~/.config/nvim/neovide.lua
-- Neovide 专用图形界面配置
-- 注意：以 `vim.g` 开头的选项可以动态生效，而环境变量需要在外部设置。

-- 可选：设置一个全局变量来标记当前是否在 Neovide 中运行
-- 这在你想要只在 Neovide 中生效的键位映射或其他设置时非常有用
vim.g.neovide = true

-----------------------------------------------------------
--               ！！！重要说明！！！
-- 以下 `vim.g.neovide_...` 的选项可以在此文件中设置并动态生效。
-- 而 `NEOVIDE_FONT` 等环境变量需要你在你的 shell 配置文件
-- （如 .bashrc, .zshrc, config.fish) 中设置。
-- 这里列出它们是为了给你一个清晰的参考。
-----------------------------------------------------------

-- ########## 需要在外部Shell中设置的环境变量 (示例) ##########
-- export NEOVIDE_FONT='FiraCode Nerd Font Mono:h12'
-- export NEOVIDE_FONT_WEIGHT='Medium'
-- export NEOVIDE_CURSOR_ANTI_ALIASING=on

-- ########## 可以在此文件中设置的动态选项 ##########

-- 界面缩放因子，可以动态调整，非常强大
vim.g.neovide_scale_factor = 1.0

-- 刷新率（帧率），根据你的显示器调整
vim.g.neovide_refresh_rate = 60

-- 动画长度（秒），设置为 0 可禁用平滑滚动
vim.g.neovide_scroll_animation_length = 0.3

-- 光标动画效果模式
-- 可选: 'railgun', 'torpedo', 'pixiedust', 'sonicboom', 'ripple', 'wireframe'
-- vim.g.neovide_cursor_vfx_mode = "wireframe"

-- 光标动画参数
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_count = 5.0
vim.g.neovide_cursor_trail_size = 0.5

-- 隐藏窗口装饰（标题栏），实现无边框效果
-- vim.g.neovide_hide_window_decorations = true

-- 全屏模式
-- vim.g.neovide_fullscreen = false

-- 浮动模糊（Windows 和 macOS 上支持）
-- vim.g.neovide_floating_blur_amount_x = 2.0
-- vim.g.neovide_floating_blur_amount_y = 2.0

-- 启用数字触摸板（macOS）
-- vim.g.neovide_touch_deadzone = 6.0
-- vim.g.neovide_touch_drag_timeout = 0.17

-----------------------------------------------------------
--                     快捷键映射
-- 用于动态交互地调整 Neovide 的设置
-----------------------------------------------------------

local function set_scale_factor(scale)
  vim.g.neovide_scale_factor = scale
end

-- 增大字体/界面 (Ctrl + +)
vim.keymap.set({ "n", "v" }, "<C-=>", function()
  set_scale_factor(vim.g.neovide_scale_factor * 1.25)
end)

-- 减小字体/界面 (Ctrl + -)
vim.keymap.set({ "n", "v" }, "<C-->", function()
  set_scale_factor(vim.g.neovide_scale_factor / 1.25)
end)

-- 重置字体/界面 (Ctrl + 0)
vim.keymap.set({ "n", "v" }, "<C-0>", function()
  set_scale_factor(1.0)
end)

-- 你可以添加更多快捷键，例如切换无边框模式
-- vim.keymap.set('n', '<F11>', function()
--   vim.g.neovide_hide_window_decorations = not vim.g.neovide_hide_window_decorations
-- end)

-----------------------------------------------------------
--                    可选：主题相关
-- 有些 GUI 主题在 Neovide 下表现更好，可以在这里设置
-----------------------------------------------------------

-- 例如，设置一个适合深色模式的 colorscheme
--vim.cmd([[colorscheme catppuccin-mocha]])

-- 设置透明背景（需要终端和主题支持）
-- vim.g.neovide_transparency = 0.95
-- vim.g.transparency = 0.95
--

vim.g.neovide_multigrid = false
-- 设置默认工作目录
local default_path = "~/Documents/.obsidian/code/" -- 替换为你想要的默认路径

-- 启动时自动切换到默认目录
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    -- 只有在没有打开文件且当前目录是家目录时才切换
    if vim.fn.argc() == 0 and vim.fn.getcwd() == vim.fn.expand("~") then
      vim.cmd("cd " .. vim.fn.expand(default_path))
      print("切换到默认目录: " .. vim.fn.getcwd())
    end
  end,
})
