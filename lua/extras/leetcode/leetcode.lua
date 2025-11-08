return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Leet",
  opts = {
    lang = "cpp",
    cn = { enabled = true, translator = true, translate_problems = true },
    storage = {
      home = "~/Documents/.obsidian/leetcode/",
      cache = "~/Documents/.obsidian/leetcode/.cache",
    },
    injector = {
      ["cpp"] = {
        imports = function()
          return {
            "#include <iostream>",
            "#include <vector>",
            "#include <string>",
            "\n",
            "using namespace std;",
          }
        end,
      },
    },
  },
  config = function(_, opts)
    require("leetcode").setup(opts)

    local keymap = vim.keymap.set
    keymap("n", "<leader>ll", "<cmd>Leet list<cr>", { desc = "Leetcode 列表" })
    keymap("n", "<leader>lt", "<cmd>Leet test<cr>", { desc = "Leetcode 测试" })
    keymap("n", "<leader>lr", "<cmd>Leet run<cr>", { desc = "Leetcode 运行" })
    keymap("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "Leetcode 提交" })
    keymap("n", "<leader>lf", "<cmd>Leet desc toggle<cr>", { desc = "Leetcode 描述" })
    keymap("n", "<leader>lR", "<cmd>Leet reset<cr>", { desc = "Leetcode 重置缓存" })
  end,
}
