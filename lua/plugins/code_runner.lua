-- nvim/lua/plugins/code_runner.lua
return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      -- [CodeRunner] 文件类型与执行命令配置
      filetype = {
        -- [CodeRunner] C 语言配置：编译并运行 C 程序
        c = {
          "cd $dir &&",
          "gcc $fileName -o $fileNameWithoutExt -lm -g -Wall &&",
          "$dir/$fileNameWithoutExt",
        },
        -- [CodeRunner] C++ 配置：编译并运行 C++ 程序
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt -g -Wall &&",
          "$dir/$fileNameWithoutExt",
        },
        -- [CodeRunner] 可根据需要添加更多语言支持：
        -- python = "python3 -u $fileName",
        -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        -- javascript = "node $fileName",
        -- typescript = "npx ts-node $fileName",
      },

      -- [CodeRunner] 终端窗口配置
      term = {
        position = "bot", -- [CodeRunner] 终端位置：bot|top|left|right
        size = 15, -- [CodeRunner] 终端窗口大小
      },

      -- [CodeRunner] 行为选项
      startinsert = true, -- [CodeRunner] 运行代码时自动进入插入模式
    })

    -- [CodeRunner] 快捷键映射配置
    vim.keymap.set({ "n", "v" }, "<leader>rr", ":RunCode<CR>", {
      noremap = true,
      silent = false,
      desc = "[CodeRunner] 运行代码（normal模式运行文件，visual模式运行选中）",
    })
    vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", {
      noremap = true,
      silent = false,
      desc = "[CodeRunner] 运行整个项目",
    })
    vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", {
      noremap = true,
      silent = false,
      desc = "[CodeRunner] 关闭运行器窗口",
    })
  end,
}
