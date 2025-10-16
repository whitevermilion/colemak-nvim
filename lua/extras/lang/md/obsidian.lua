return {
  "epwalsh/obsidian.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/Documents/.obsidian/code/",
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    ui = {
      enable = false, -- 关键：禁用 Obsidian 的 UI 渲染
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- 保留功能性的快捷键，不依赖 UI
    vim.keymap.set("n", "<CR>", function()
      -- 你的智能跳转逻辑
    end, { expr = true, desc = "跳转链接或新建行" })
  end,
}
