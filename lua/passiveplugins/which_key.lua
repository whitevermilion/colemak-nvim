-- nvim/lua/passiveplugins/which_key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    show_help = false,
    show_keys = false,
    delay = 500,
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
