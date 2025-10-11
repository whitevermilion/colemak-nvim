-- 确保已安装 `Shatur/neovim-tasks`
return {
  'Shatur/neovim-tasks',
  dependencies = {
    'nvim-lua/plenary.nvim' -- 需要plenary.nvim
  },
  opts = {
    default_params = {
      -- 为CMake任务配置默认参数
      cmake = {
        cmd = 'cmake', -- CMake命令
        build_dir = tostring(vim.fn.getcwd()) .. '/build', -- 构建目录
        build_type = 'Debug',
        -- 生成编译命令数据库，有助于其他插件
        args = {
          configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja' }
        }
      }
    },
    save_before_run = true, -- 运行任务前保存文件
    params_file = 'neovim.json' -- 存储任务参数的文件名
  },
  config = function(_, opts)
    require('tasks').setup(opts)
    -- 设置一些快捷键（可按需修改）
    vim.keymap.set("n", "<leader>tl", "<cmd>TasksList<CR>", { desc = "List available tasks" })
    vim.keymap.set("n", "<leader>tr", "<cmd>TasksRun<CR>", { desc = "Run a task" })
  end,
}
