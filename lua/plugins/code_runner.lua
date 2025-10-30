-- nvim/lua/plugins/code_runner.lua
return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      -- 开始：文件类型与执行命令配置
      filetype = {
        c = {
          "cd $dir &&",
          "gcc $fileName -o $fileNameWithoutExt -lm -g -Wall &&",
          "$dir/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt -g -Wall &&",
          "$dir/$fileNameWithoutExt",
        },
      },
      -- 结束：文件类型与执行命令配置
      -- 在终端中运行代码，支持输入
      term = {
        position = "bot",
        size = 15,
      },
      -- 运行前是否保存文件
      startinsert = true,
    })
    -- 设置快捷键
    vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run Code" })
    vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false, desc = "Run File" })
    vim.keymap.set(
      "n",
      "<leader>rft",
      ":RunFile tab<CR>",
      { noremap = true, silent = false, desc = "Run File in New Tab" }
    )
    vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false, desc = "Run Project" })
    vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false, desc = "Close Runner" })
  end,
}
