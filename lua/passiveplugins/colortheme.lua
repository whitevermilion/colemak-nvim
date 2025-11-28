-- nvim/lua/passiveplugins/colortheme.lua
return {

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
