-- nvim/lua/plugins/editor.lua
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
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
    },
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
  },
}
