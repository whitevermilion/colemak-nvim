return {
  -- GitHub Dark 主题 (默认)
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          dim_inactive = true,
          styles = { comments = "NONE", functions = "NONE" },
        },
      })
      vim.api.nvim_set_hl(0, 'Cursor', { fg = '#00CD00', bg = 'green' })      -- 绿色光标
    end,
  },

  -- Everforest 主题 (备用)
  {
    "sainnhe/everforest",
    lazy = false, -- 改为立即加载
    config = function()
      vim.g.everforest_config = {
        background = "medium",
        ui_contrast = "low",
        disable_italic_comment = 1,
      }
      vim.api.nvim_set_hl(0, 'Cursor', { fg = '#00CD00', bg = 'green' })      -- 绿色光标
    end,
  },

  -- Tokyo Night 主题 (备用)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      dim_inactive = true,
    },
  },

  -- 主题切换命令
  {
    "LazyVim/LazyVim",
    config = function()
      -- 时间检测函数
      local function set_theme_by_time()
        local current_hour = tonumber(os.date("%H"))
        local is_daytime = current_hour >= 7 and current_hour < 19
        
        if is_daytime then
          vim.cmd.colorscheme("github_dark")
          vim.api.nvim_set_hl(0, 'Cursor', { fg = '#FFFFFF', bg = '#FFFFFF' })
          print("我是人间惆怅客，知君何事泪纵横。断肠声里忆平生。")
        else
          vim.cmd.colorscheme("everforest")
          print("书似青山常堆叠，灯如红豆最相思")
        end
      end

      -- 初始化时设置主题
      set_theme_by_time()

      -- GitHub Dark 主题命令
      vim.api.nvim_create_user_command("Gitdark", function()
        vim.cmd.colorscheme("github_dark")
        vim.api.nvim_set_hl(0, 'Cursor', { fg = '#FFFFFF', bg = '#FFFFFF' })
        print(" Thoroughly conscious ignorance is the prelude to every real advance in science")
      end, {})

      -- Everforest 主题命令
      vim.api.nvim_create_user_command("Ever", function()
        vim.cmd.colorscheme("everforest")
        print("When the moonlight shines on the ground,The tree of life will be awaken")
      end, {})

      -- Tokyo Night 主题命令
      vim.api.nvim_create_user_command("Tokyo", function()
        vim.cmd("Lazy load tokyonight")
        vim.cmd.colorscheme("tokyonight-night")
        print("🌃 Tokyo Night 主题已启用")
      end, {})
 
      -- 主题浏览器
      vim.api.nvim_create_user_command("ThemeList", function()
        vim.cmd("Telescope colorscheme")
      end, {})
    end,
  },
}
