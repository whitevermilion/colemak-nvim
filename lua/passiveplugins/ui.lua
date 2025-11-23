-- nvim/lua/passiveplugins/ui.lua
return {
  -- lualine.nvim - 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lualine = require("lualine")
      local theme = "auto"

      lualine.setup({
        options = {
          theme = theme,
          component_separators = { left = "|", right = "|" },
          section_separators = {
            left = vim.fn.exists("g:loaded_nerd_font") and " " or "",
            right = vim.fn.exists("g:loaded_nerd_font") and "" or "",
          },
          disabled_filetypes = {
            statusline = { "NvimTree", "alpha", "dashboard", "Trouble", "Outline" },
          },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = {
            { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
            "encoding",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_c = { "filename" },
          lualine_x = { "location" },
        },
        extensions = { "nvim-tree", "toggleterm" },
      })
    end,
  },

  -- indent-blankline.nvim - 缩进参考线
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { "dashboard", "alpha" },
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 5000,
        max_width = 60,
        stages = "fade_in_slide_out",
        -- render = "minimal",
        level = "info",
        background_colour = "#1e222a",
        icons = {
          ERROR = "Error（>﹏<）",
          WARN = "Warn(・□・;)!",
          INFO = "Info（´▽｀）",
          DEBUG = "Debug（‘・ω・）?",
          TRACE = "Trace（・-・）",
        },
      })
      vim.notify = notify

      -- 触发自定义事件，通知其他插件 notify 已加载
      vim.api.nvim_exec_autocmds("User", { pattern = "ActuallyLoaded" })
    end,
  },
}
