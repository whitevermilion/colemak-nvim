--在侧边显示文件树，支持文件创建删除重名
return {
  --在侧边显示文件树，支持文件创建删除重名
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>uf", ":NvimTreeToggle<CR>", desc = "Toggle File Tree" }, -- 文件树开关
  },
  opts = {
    -- 新增：文件过滤配置 - 显示被 .gitignore 忽略的文件
    filters = {
      dotfiles = false, -- 显示点文件（以 . 开头的文件）
      git_ignored = false, -- 关键设置：显示被 gitignore 忽略的文件
      custom = {}, -- 自定义过滤规则，留空表示不过滤
      exclude = {}, -- 排除文件列表，留空表示不排除
    },

    -- 界面美化
    renderer = {
      icons = {
        glyphs = {
          git = {
            unstaged = "✗", -- 未暂存文件标识
            staged = "✓", -- 已暂存文件标识
            unmerged = "",
          },
        },
        show = {
          file = true, -- 显示文件图标
          folder = true, -- 显示文件夹图标
          folder_arrow = true, -- 显示折叠箭头
          git = true, -- 显示 Git 状态
        },
      },
      indent_markers = {
        enable = true, -- 显示缩进标记线
      },
      highlight_git = true, -- 高亮 Git 状态变化的文件
    },

    -- Git 相关配置
    git = {
      enable = true, -- 启用 Git 集成
      ignore = false, -- 关键设置：不基于 .gitignore 过滤文件显示
      timeout = 400, -- Git 操作超时时间
    },

    -- 视图行为
    view = {
      width = 25, -- 侧边栏宽度
      side = "left", -- 显示在左侧（可选 "right"）
      relativenumber = true, -- 显示相对行号
      number = true, -- 显示绝对行号
      signcolumn = "no", -- 标记列
    },

    -- 文件操作配置
    actions = {
      open_file = {
        quit_on_open = false, -- 打开文件后自动关闭树
        resize_window = true, -- 根据文件内容自动调整窗口大小
        window_picker = {
          enable = true, -- 允许通过窗口选择器打开文件
        },
      },
      change_dir = {
        global = true, -- 切换目录时同步 Neovim 工作目录
      },
    },

    -- 自动行为
    hijack_netrw = true, -- 禁用默认的 netrw 文件浏览器
    sync_root_with_cwd = true, -- 文件树根目录与当前工作目录同步
    update_focused_file = {
      enable = true, -- 自动聚焦当前打开的文件
      update_root = true, -- 自动更新根目录
    },

    -- Colemak 键位映射
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      -- 辅助函数
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- 滚动优化（如果觉得滚动慢）
      vim.g.neovide_scroll_animation_length = 0.15 -- 默认是 0.3
      -- 首先执行默认映射
      api.config.mappings.default_on_attach(bufnr)

      -- 使用更稳定的导航函数
      -- n 向下移动
      vim.keymap.set("n", "n", function()
        vim.cmd("normal! j")
      end, opts("Down"))

      -- e 向上移动
      vim.keymap.set("n", "e", function()
        vim.cmd("normal! k")
      end, opts("Up"))

      -- 添加切换显示被忽略文件的快捷键
      vim.keymap.set("n", "<leader>gi", function()
        local view = require("nvim-tree.view")
        local tree = require("nvim-tree")

        -- 获取当前配置
        local config = tree.get_config()

        -- 切换 git_ignored 过滤
        config.filters.git_ignored = not config.filters.git_ignored
        config.git.ignore = not config.git.ignore

        -- 重新设置配置
        tree.setup(config)

        -- 刷新视图
        if view.is_visible() then
          view.close()
          view.open()
        end

        -- 显示当前状态
        if config.filters.git_ignored then
          print("隐藏被 .gitignore 的文件")
        else
          print("显示所有文件（包括被 .gitignore 的）")
        end
      end, opts("Toggle git ignored files"))

      -- 禁用原来的 j 和 k 键
      vim.keymap.set("n", "j", "<Nop>", { buffer = bufnr, desc = "Disable j key" })
      vim.keymap.set("n", "k", "<Nop>", { buffer = bufnr, desc = "Disable k key" })
    end,
  },
}
