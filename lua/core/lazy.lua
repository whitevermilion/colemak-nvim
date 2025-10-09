-- Neovim 插件管理器配置
-- 文件：lua/core/lazy.lua
-- 作用：配置 lazy.nvim 插件管理器，管理所有插件的安装、加载和更新

-- 设置 lazy.nvim 的安装路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 检查 lazy.nvim 是否已安装，如果没有则从 GitHub 克隆
if not vim.uv.fs_stat(lazypath) then
  -- 克隆命令，使用稳定分支并过滤不必要的文件以加快下载
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", 
    "--branch=stable", lazyrepo, lazypath
  })
  
  -- =============================================
  -- 改进点 1: 增强错误处理
  -- 作用：在网络问题或权限问题时给用户明确提示
  -- 而不是让 Neovim 启动失败且原因不明
  -- =============================================
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { " 无法安装 lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\n 可能的原因：网络连接问题或 Git 未安装\n" },
      { "按任意键退出..." },
    }, true, {})
    vim.fn.getchar()  -- 等待用户按键
    os.exit(1)        -- 退出 Neovim
  end
end

-- 将 lazy.nvim 添加到 Neovim 的运行时路径，这样才能 require
vim.opt.rtp:prepend(lazypath)

-- =============================================
-- 2. 主配置部分 - 设置 lazy.nvim 的行为
-- =============================================
require("lazy").setup({
  spec = {
    { import = "plugins" },           -- 核心工作流插件
    { import = "passiveplugins" },    -- 不常用插件，减少内存占用
    { import = "extras/dap" },        -- 调试适配协议，用于代码调试
    { import = "extras/lang/c" },     -- C/C++ 语言特定支持
    { import = "extras/lang/md" },    -- Markdown 写作增强
    { import = "extras/ai" },         -- AI 编程助手（如 Copilot）
  },
  
  -- =============================================
  -- 改进点 3: 明确的默认行为配置
  -- 作用：统一控制插件的加载时机
  -- lazy = false: 启动时立即加载所有插件
  -- lazy = true:  按需懒加载，加快启动速度但可能影响初次使用体验
  -- =============================================
  defaults = {
    lazy = true,
    -- 设为 true 可加快启动速度，但第一次使用功能时会有延迟
    version = stable,
    -- 使用最新版本，可指定为 "stable" 使用稳定版
  },
  
  -- =============================================
  -- 改进点 4: 性能优化配置
  -- 作用：禁用 Neovim 内置的冗余插件，减少内存占用和启动时间
  -- =============================================
  performance = {
    rtp = {
      disabled_plugins = {
        -- 网络相关插件（通常用 nvim-tree 等替代）
        "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
        
        -- 归档文件支持（很少在编辑器内直接使用）
        "tarPlugin", "zipPlugin",
        
        -- 格式转换插件（不常用）
        "2html_plugin", "tohtml",
        
        -- 其他冗余功能
        "getscript", "getscriptPlugin", "gzip", "logipat",
        "matchit", "matchparen", "rrhelper", "spellfile_plugin",
        "vimball", "vimballPlugin", "tutor",
      },
    },
    
    -- 启用缓存，提升插件加载性能
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
    },
  },
  
  -- =============================================
  -- 改进点 5: 智能更新检查
  -- 作用：自动检查插件更新，但不自动安装，避免破坏稳定性
  -- =============================================
  checker = {
    enabled = true,      -- 启用更新检查
    notify = false,      -- 不弹出通知打扰工作
    frequency = 86400,   -- 每天检查一次（秒）
    concurrency = 1,     -- 同时检查的插件数量
  },
  
  -- =============================================
  -- 改进点 6: 安装时配置
  -- 作用：安装插件时自动设置颜色方案，提供一致的视觉体验
  -- =============================================
  install = {
    colorscheme = { 
      "habamax",        -- 安装完成后使用的默认主题
      "tokyonight",     -- 备选主题
    },
    missing = true,     -- 自动安装 missing 的依赖
  },
  
  -- =============================================
  -- 改进点 7: 增强的 UI 配置
  -- 作用：提升插件管理器的视觉体验和可用性
  -- =============================================
  ui = {
    border = "rounded",  -- 圆角边框，更美观
    
    -- 自定义标题
    title = "Lazy 插件管理器",
    title_pos = "center",  -- 标题位置
    
    -- 窗口大小
    size = {
      width = 0.9,
      height = 0.9,
    },
    
    -- 缩略图配置
    thumb = {
      position = "top",
      size = 10,
    },
  },
  
  -- =============================================
  -- 改进点 8: 调试配置
  -- 作用：在遇到插件问题时可以启用调试模式
  -- =============================================
  debug = false,  -- 设为 true 可查看详细的插件加载日志
})

