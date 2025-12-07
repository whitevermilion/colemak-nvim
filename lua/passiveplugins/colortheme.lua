-- nvim/lua/passiveplugins/colortheme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    cmd = "TokyonightDay",
    config = function()
      require("tokyonight").setup({
        style = "day", -- 核心：指定白天变体
      })
      vim.api.nvim_create_user_command("TokyonightDay", function() vim.cmd.colorscheme("tokyonight") end, {})
    end,
  },
  -- Nordic 增强主题 (高对比度北极蓝风格)
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    cmd = "Nordic",
    config = function()
      require("nordic").setup({
        -- 这里可以放置你的自定义配置，以下是一些常用选项：
        bright_border = true, -- 使用更亮的边框颜色
        -- transparent_bg = false,      -- 设置背景透明 (若需要)
        italic_comments = true, -- 让注释变为斜体
        theme = "nord", -- 也可选 'nord' 以获得更接近原版的体验
      })
      vim.api.nvim_create_user_command("Nordic", function() vim.cmd.colorscheme("nordic") end, {})
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    cmd = "RosePine",
    config = function()
      vim.api.nvim_create_user_command("RosePine", function() vim.cmd.colorscheme("rose-pine") end, {})
    end,
  },

  -- Cyberdream 赛博朋克
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    cmd = "Cyberdream",
    config = function()
      require("cyberdream").setup({
        theme = "dark",
        transparent = false,
        italic_comments = true,
      })

      vim.api.nvim_create_user_command("Cyberdream", function() vim.cmd.colorscheme("cyberdream") end, {})
    end,
  },

  -- Gruvbox Material 材质绿调
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    cmd = "GruvboxMaterial",
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "material"

      vim.api.nvim_create_user_command("GruvboxMaterial", function() vim.cmd.colorscheme("gruvbox-material") end, {})
    end,
  },

  -- Everforest 永恒森林
  {
    "sainnhe/everforest",
    lazy = true,
    cmd = "Everforest",
    config = function()
      vim.g.everforest_background = "hard"

      vim.api.nvim_create_user_command("Everforest", function() vim.cmd.colorscheme("everforest") end, {})
    end,
  },
}
