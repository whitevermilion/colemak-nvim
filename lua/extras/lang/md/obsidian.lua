-- nvim/lua/extras/lang/md/obsidian.lua
return {
  "epwalsh/obsidian.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/Documents/.obsidian/",
    notes_subdirs = { "code", "note", "shelllab" },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- 核心链接功能优化
    note_id_func = function(title)
      return title:gsub(" ", "-"):lower() -- 自动生成一致的链接ID
    end,

    preferred_link_style = "wiki", -- 使用 [[wiki风格]] 链接

    ui = {
      enable = true,
      dirable = {
        "outline",
        "backlinks",
        "hover",
      },
    },

    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.keymap.set("n", "<CR>", function() end, { expr = true, desc = "跳转链接或新建行" })
  end,
}
