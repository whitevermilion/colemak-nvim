return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Leet",
  opts = {
    lang = "cpp",
    cn = { enabled = true, translator = true, translate_problems = true },
    storage = {
      home = "~/Code/vim_leetcode_home/",
      cache = "~/Code/vim_leetcode_home/.cache/",
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
    -- 添加 hooks 配置
    hooks = {
      -- 当进入 LeetCode 问题时重新映射 Tab 键
      ["question_enter"] = {
        function()
          -- 保存原来的 Tab 映射
          if not vim.g.original_tab_mapping then vim.g.original_tab_mapping = vim.fn.maparg("<Tab>", "n") end

          -- 设置新的 Tab 映射
          vim.keymap.set("n", "<Tab>", "<cmd>Leet tabs<CR>", {
            buffer = true,
            desc = "LeetCode Tabs",
          })
        end,
      },
      -- 当离开 LeetCode 时恢复原来的 Tab 映射
      ["leave"] = {
        function()
          -- 恢复原来的 Tab 映射
          if vim.g.original_tab_mapping then
            vim.keymap.set("n", "<Tab>", vim.g.original_tab_mapping, {
              buffer = false,
            })
            vim.g.original_tab_mapping = nil
          end
        end,
      },
    },
  },
  config = function(_, opts)
    require("leetcode").setup(opts)

    local keymap = vim.keymap.set
    keymap("n", "<leader>ll", "<cmd>Leet list<cr>", { desc = "[Leet]列表" })
    keymap("n", "<leader>lt", "<cmd>Leet test<cr>", { desc = "[Leet]测试" })
    keymap("n", "<leader>lr", "<cmd>Leet run<cr>", { desc = "[Leet]运行" })
    keymap("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "[Leet]提交" })
    keymap("n", "<leader>lf", "<cmd>Leet desc toggle<cr>", { desc = "[Leet]描述" })
    keymap("n", "<leader>lu", "<cmd>Leet last_submit<cr>", { desc = "[Leet]上次提交代码" })
  end,
}
