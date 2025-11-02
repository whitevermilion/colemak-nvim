-- nvim/lua/passiveplugins/image.lua
return {
  "3rd/image.nvim",
  event = "VeryLazy",

  -- 可选依赖
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 可选：用于文件图标
  },

  config = function()
    local image = require("image")

    image.setup({
      backend = "kitty", -- 根据你的终端选择
      max_width = 800,
      max_height = 600,
      max_width_window_percentage = 60,
      max_height_window_percentage = 60,

      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
      },

      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    })
  end,
}
