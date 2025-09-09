return {
  -- 全局搜索替换插件
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = { { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search & Replace" } },
  },

  -- 快速跳转增强插件
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      show_help = false,
      show_keys = false,
      delay = 500
    },
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  -- Git 集成插件
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      signcolumn = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 500,
      },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      
      -- 直接设置全局快捷键，不需要自动命令
      local map = vim.keymap.set
      map("n", "<leader>ghs", function() require("gitsigns").stage_hunk() end, { desc = "Git Stage hunk" })
      map("n", "<leader>ghr", function() require("gitsigns").reset_hunk() end, { desc = "Git Reset hunk" })
      map("n", "<leader>ghp", function() require("gitsigns").preview_hunk() end, { desc = "Git Preview hunk" })
      map("n", "<leader>ghd", function() require("gitsigns").diffthis() end, { desc = "Git Diff against staged" })
   end
  },

  -- 诊断和问题管理插件
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
  }
}
