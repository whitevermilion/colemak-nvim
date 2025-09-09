return {
  --在侧边显示文件树，支持文件创建删除重名
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>uf", ":NvimTreeToggle<CR>", desc = "Toggle File Tree" }, -- 文件树开关
  },
  opts = {
    -- 界面美化
    renderer = {
      icons = {
        glyphs = {
          git = {
            unstaged = "✗", -- 未暂存文件标识
            staged = "✓",   -- 已暂存文件标识
            unmerged = "",
          },
        },
        show = {
          file = true,      -- 显示文件图标
          folder = true,    -- 显示文件夹图标
          folder_arrow = true, -- 显示折叠箭头
          git = true,       -- 显示 Git 状态
        },
      },
      indent_markers = {
        enable = true,      -- 显示缩进标记线
      },
      highlight_git = true, -- 高亮 Git 状态变化的文件
    },

    -- 视图行为
    view = {
      width = 25,           -- 侧边栏宽度
      side = "left",        -- 显示在左侧（可选 "right"）
      relativenumber = true,-- 显示相对行号
      number = true,       -- 显示绝对行号
      signcolumn = "no",   -- 标记列
    },

    -- 文件操作配置
    actions = {
      open_file = {
        quit_on_open = false,    -- 打开文件后自动关闭树
        resize_window = true,   -- 根据文件内容自动调整窗口大小
        window_picker = {
          enable = true,        -- 允许通过窗口选择器打开文件
        },
      },
      change_dir = {
        global = true,          -- 切换目录时同步 Neovim 工作目录
      },
    },

    -- 自动行为
    hijack_netrw = true,        -- 禁用默认的 netrw 文件浏览器
    sync_root_with_cwd = true,  -- 文件树根目录与当前工作目录同步
    update_focused_file = {
      enable = true,            -- 自动聚焦当前打开的文件
      update_root = true,       -- 自动更新根目录
    },

    -- Colemak 键位映射
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      -- 辅助函数
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 首先执行默认映射
      api.config.mappings.default_on_attach(bufnr)

      -- 然后覆盖移动键位
      -- n 向下移动（下一个项目）
      vim.keymap.set('n', 'n', api.node.navigate.sibling.next, opts('Next Sibling'))
      -- e 向上移动（上一个项目）
      vim.keymap.set('n', 'e', api.node.navigate.sibling.prev, opts('Previous Sibling'))
      
      -- 不再尝试删除 j 和 k 的映射，因为它们可能不存在
      -- 如果你发现 j 和 k 仍然有功能，可以尝试重新映射它们到无害的操作
      vim.keymap.set('n', 'j', '<Nop>', { buffer = bufnr, desc = 'Disable j key' })
      vim.keymap.set('n', 'k', '<Nop>', { buffer = bufnr, desc = 'Disable k key' })
    end
  },
}
