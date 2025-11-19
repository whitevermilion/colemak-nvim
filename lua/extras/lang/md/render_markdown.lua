-- nvim/lua/extras/lang/md/render_markdown.lua
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    {

      "nvim-treesitter/nvim-treesitter",
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "llm", "markdown" },
          callback = function() vim.treesitter.start(0, "markdown") end,
        })
      end,
    },
    "nvim-mini/mini.icons",
  },
  ft = { "markdown", "llm" }, -- 如果阅读llm.nvim插件的保存记录，可以优化llm文件的体验
  opts = {
    restart_highlighter = true,
    highlight = {
      cursor_line = false,
    },
    heading = {
      icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
      border = true,
      render_modes = true,
    },
    sign = { enabled = false },
    code = {
      width = "block",
      min_width = 80,
      border = "thin",
      left_pad = 1,
      right_pad = 1,
      highlight_inline = "RenderMarkdownCodeInfo",
    },
    checkbox = {
      unchecked = {
        icon = "󰄱",
        highlight = "RenderMarkdownCodeFallback",
        scope_highlight = "RenderMarkdownCodeFallback",
      },
      checked = {
        icon = "󰄵",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = "RenderMarkdownUnchecked",
      },
      custom = {
        question = {
          raw = "[?]",
          rendered = "",
          highlight = "RenderMarkdownError",
          scope_highlight = "RenderMarkdownError",
        },
        todo = {
          raw = "[>]",
          rendered = "󰦖",
          highlight = "RenderMarkdownInfo",
          scope_highlight = "RenderMarkdownInfo",
        },
        canceled = {
          raw = "[-]",
          rendered = "",
          highlight = "RenderMarkdownCodeFallback",
          scope_highlight = "@text.strike",
        },
        important = {
          raw = "[!]",
          rendered = "",
          highlight = "RenderMarkdownWarn",
          scope_highlight = "RenderMarkdownWarn",
        },
        favorite = {
          raw = "[~]",
          rendered = "",
          highlight = "RenderMarkdownMath",
          scope_highlight = "RenderMarkdownMath",
        },
      },
    },
    pipe_table = {
      alignment_indicator = "─",
      border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
    },
    anti_conceal = {
      disabled_modes = { "n" },
      ignore = {
        bullet = true,
        head_border = true,
        head_background = true,
      },
    },
    win_options = { concealcursor = { rendered = "nvc" } },
    list_chars = {
      unordered = "•",
    },
    completions = {
      blink = { enabled = true },
      lsp = { enabled = true },
    },
    bold = {
      enabled = false,
    },
    italic = {
      enabled = false,
    },
    link = {
      wiki = {
        icon = "󰌹 ",
        highlight = "RenderMarkdownWikiLink",
        scope_highlight = "RenderMarkdownWikiLink",
      },
      image = " ",
      custom = {
        github = { pattern = "github", icon = " " },
        gitlab = { pattern = "gitlab", icon = "󰮠 " },
        youtube = { pattern = "youtube", icon = " " },
        cern = { pattern = "cern.ch", icon = " " },
      },
      hyperlink = " ",
    },
    tables = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- 设置双链为紫色
    vim.api.nvim_set_hl(0, "RenderMarkdownWikiLink", {
      fg = "#c678dd", -- 紫色
      underline = false,
    })
  end,
}
