-- nvim/lua/passiveplugins/colorscheme.lua
return {
  -- Catppuccin 主题 - 简化版
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "frappe", -- 默认使用 frappe 主题
      transparent_background = false,
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      -- 根据时间自动切换 Catppuccin 主题变体
      local current_hour = tonumber(os.date("%H"))
      if current_hour >= 7 and current_hour < 19 then
        vim.cmd.colorscheme("catppuccin-frappe") -- 白天使用 frappe
      else
        vim.cmd.colorscheme("catppuccin-mocha") -- 晚上使用 mocha（深色）
      end
    end,
  },
}
