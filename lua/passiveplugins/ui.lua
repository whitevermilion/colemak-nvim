return {
  -- lualine.nvim - 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local status, lualine = pcall(require, "lualine")
      if not status then
        vim.notify("没有找到 lualine", vim.log.levels.WARN)
        return
      end

      local theme = pcall(require, "lualine.themes.auto") and "auto" or "tokyonight"

      lualine.setup({
        options = {
          theme = theme,
          component_separators = { left = "|", right = "|" },
          section_separators = {
            left = vim.fn.exists("g:loaded_nerd_font") and " " or "",
            right = vim.fn.exists("g:loaded_nerd_font") and "" or ""
          },
          disabled_filetypes = {
            statusline = { "NvimTree", "alpha", "dashboard", "Trouble", "Outline" }
          },
          globalstatus = true,
          refresh = { statusline = 500 }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = {
            {
              "fileformat",
              symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
              fmt = function(str)
                return vim.bo.fileformat ~= "unix" and str or ""
              end
            },
            {
              "encoding",
              fmt = function(str)
                return vim.bo.fileencoding ~= "utf-8" and str or ""
              end
            },
            "filetype"
          },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
        inactive_sections = {
          lualine_c = { "filename" },
          lualine_x = { "location" }
        },
        extensions = { "nvim-tree", "toggleterm" }
      })
    end
  },

  -- indent-blankline.nvim - 缩进参考线
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { "dashboard", "alpha" }
      }
    }
  },

  -- nvim-notify - 通知系统
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 5000,
        max_width = 60,
        stages = "fade_in_slide_out",
        render = "minimal",
        level = "info",
        background_colour = "#1e222a",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = ""
        }
      })
      vim.notify = notify
    end
  }
}
