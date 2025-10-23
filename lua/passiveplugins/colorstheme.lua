return {
  -- GitHub Dark 主题
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup()

      -- 主题切换命令
      vim.api.nvim_create_user_command("Gitdark", function()
        vim.cmd.colorscheme("github_dark")
        vim.notify(
          "Thoroughly conscious ignorance is the prelude to every real advance in science",
          vim.log.levels.INFO,
          {
            title = "主题切换",
            timeout = 1000,
          }
        )
      end, { desc = "切换到 GitHub Dark 主题" })

      vim.api.nvim_create_user_command("Ever", function()
        vim.cmd.colorscheme("everforest")
        vim.notify("When the moonlight shines on the ground,\n The tree of life will be awaken", vim.log.levels.INFO, {
          title = "主题切换",
          timeout = 1000,
        })
      end, { desc = "切换到 Everforest 主题" })

      -- 启动时根据时间设置主题
      local current_hour = tonumber(os.date("%H"))
      if current_hour >= 7 and current_hour < 19 then
        vim.cmd.colorscheme("github_dark")
      else
        vim.cmd.colorscheme("everforest")
      end
    end,
  },

  -- Everforest 主题
  {
    "sainnhe/everforest",
    lazy = false,
  },
}
