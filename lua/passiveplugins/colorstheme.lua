-- nvim/lua/passiveplugins/colorscheme.lua
return {
  -- Catppuccin 主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      -- 只保留最核心的配置
      flavour = "frappe", -- 主题变体: latte(浅色), frappe(柔和), macchiato(中等), mocha(深色)
      transparent_background = false, -- 是否透明背景
      term_colors = true, -- 在终端中启用主题颜色
      integrations = {
        -- 只保留你实际使用的插件集成
        cmp = true, -- 代码补全插件
        gitsigns = true, -- Git 状态指示器
        nvimtree = true, -- 文件树
        telescope = true, -- 搜索插件
        treesitter = true, -- 语法高亮
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      -- 启动时根据时间设置主题
      local current_hour = tonumber(os.date("%H"))
      if current_hour >= 7 and current_hour < 19 then
        vim.cmd.colorscheme("catppuccin-frappe") -- 白天使用 Catppuccin Frappé
      else
        vim.cmd.colorscheme("everforest") -- 晚上使用 Everforest
      end
    end,
  },

  -- Everforest 主题
  {
    "sainnhe/everforest",
    lazy = false,
  },
}
