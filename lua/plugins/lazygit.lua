return {
  "kdheepak/lazygit.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "[LazyGit]" },
  },
  config = function()
    -- 创建 :lazygit 命令别名
    vim.api.nvim_create_user_command("Lazygit", "LazyGit", {
      desc = "Open LazyGit",
    })
  end,
}
