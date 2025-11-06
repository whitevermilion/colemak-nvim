return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "Leet",
  },
  opts = {
    lang = "cpp",
    cn = {
      enabled = true,
      translator = true,
      translate_problems = true,
    },

    storage = {
      home = "~/Documents/.obsidian/leetcode/",
      cache = "~/Documents/.obsidian/leetcode/.cache",
    },

    -- C++ 模板
    injector = {
      ["cpp"] = {
        imports = function()
          return {
            "#include <iostream>",
            "#include <vector>",
            "#include <string>",
            "using namespace std;",
          }
        end,
      },
    },
  },

  config = function(_, opts)
    print("leetcode.nvim 开始加载...")

    local ok, leetcode = pcall(require, "leetcode")
    if not ok then
      print("❌ 加载 leetcode 模块失败: " .. leetcode)
      return
    end

    leetcode.setup(opts)
    print("✅ leetcode.nvim 配置完成")

    vim.keymap.set("n", "<leader>lt", "<cmd>Leet list<cr>", { desc = "Leet List" })
    vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<cr>", { desc = "LeetCode: 打开题目列表" })
    vim.keymap.set("n", "<leader>lt", "<cmd>Leet test<cr>", { desc = "LeetCode: 测试代码" })
    vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<cr>", { desc = "LeetCode: 运行代码" })
    vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "LeetCode: 提交答案" })
    vim.keymap.set("n", "<leader>lf", "<cmd>Leet desc toggle<cr>", { desc = "LeetCode: 切换题目描述" })
    print("✅ 基础键映射设置完成")
  end,
}
