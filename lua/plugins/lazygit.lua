return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    -- 可选：自定义 LazyGit 浮动窗口
    require("lazygit").setup({
      floating_window_winblend = 0, -- 透明度
      floating_window_scaling_factor = 0.9, -- 窗口缩放
      use_neovim_remote = true, -- 使用 nvr 更好的集成
    })
  end,
}
