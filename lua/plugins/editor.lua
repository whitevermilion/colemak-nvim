-- nvim/lua/plugins/editor.lua
return {
  -- 全局搜索替换插件
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = { { "<leader>sr", "<cmd>GrugFar<cr>", desc = "[GrugFar] Search & Replace" } },
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
        function() require("flash").jump() end,
        desc = "Flash Jump",
      },
    },
  },
}
