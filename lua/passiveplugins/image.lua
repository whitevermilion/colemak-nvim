-- nvim/lua/passiveplugins/image.lua
return {
  "3rd/image.nvim",
  event = "VeryLazy",
  build = false,

  -- 可选依赖
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 可选：用于文件图标
  },

  config = function()
    local image = require("image")

    image.setup({
      -- ========== 后端配置 ==========
      backend = "kitty", -- 默认: "kitty" | 可选: "ueberzug", "sixel"
      processor = "magick_cli", -- 默认: "magick_cli" | 可选: "magick_rock"

      -- ========== 图像尺寸限制 ==========
      max_width = 800, -- 默认: nil (无限制)
      max_height = 600, -- 默认: nil (无限制)
      max_width_window_percentage = 60, -- 默认: nil (无限制)
      max_height_window_percentage = 60, -- 默认: 50
      scale_factor = 1.0, -- 默认: 1.0

      -- ========== 窗口行为 ==========
      window_overlap_clear_enabled = false, -- 默认: false
      window_overlap_clear_ft_ignore = { -- 默认:
        "cmp_menu",
        "cmp_docs",
        "snacks_notif",
        "scrollview",
        "scrollview_sign",
      },
      editor_only_render_when_focused = false, -- 默认: false
      tmux_show_only_in_active_window = false, -- 默认: false

      -- ========== 文件处理 ==========
      hijack_file_patterns = { -- 默认:
        "*.png",
        "*.jpg",
        "*.jpeg",
        "*.gif",
        "*.webp",
        "*.avif",
        "*.svg",
      },

      -- ========== 集成配置 ==========
      integrations = {
        markdown = {
          enabled = true, -- 默认: true
          clear_in_insert_mode = true, -- 默认: false
          download_remote_images = true, -- 默认: true
          only_render_image_at_cursor = true, -- 默认: false
          only_render_image_at_cursor_mode = "popup", -- 默认: "popup" | 可选: "inline"
          floating_windows = false, -- 默认: false
          filetypes = { "markdown", "vimwiki", "quarto" }, -- 默认: { "markdown", "vimwiki" }

          -- 可选: 自定义图像路径解析
          -- resolve_image_path = function(document_path, image_path, fallback)
          --   return fallback(document_path, image_path)
          -- end,
        },
        neorg = {
          enabled = true, -- 默认: true
          clear_in_insert_mode = false, -- 默认: false
          download_remote_images = true, -- 默认: true
          only_render_image_at_cursor = false, -- 默认: false
          filetypes = { "norg" }, -- 默认: { "norg" }
        },
        typst = {
          enabled = true, -- 默认: true
          filetypes = { "typst" }, -- 默认: { "typst" }
        },
        html = {
          enabled = false, -- 默认: false
        },
        css = {
          enabled = false, -- 默认: false
        },
      },
    })

    -- ========== 可选: API 使用示例 ==========
    -- 启用/禁用插件
    -- require("image").enable()
    -- require("image").disable()
    -- print(require("image").is_enabled())

    -- 从文件渲染图像
    -- local image_obj = require("image").from_file("/path/to/image.png", {
    --   id = "my_image_id", -- 可选
    --   window = 1000, -- 可选
    --   buffer = 1000, -- 可选
    --   with_virtual_padding = true, -- 可选
    --   inline = true, -- 可选
    --   x = 1, y = 1, width = 10, height = 10, -- 可选几何参数
    -- })

    -- 图像操作
    -- image_obj:render()
    -- image_obj:clear()
    -- image_obj:move(x, y)
    -- image_obj:brightness(value)
    -- image_obj:saturation(value)
    -- image_obj:hue(value)

    -- 创建报告
    -- require("image").create_report()
  end,
}
