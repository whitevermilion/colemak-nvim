return {
  "epwalsh/obsidian.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/Documents/.obsidian/code/",  -- 你的笔记目录
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    mappings = {
      -- 跳转到链接
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- 创建或跟随链接
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
    follow_url_func = function(url)
      vim.fn.jobstart({"open", url})  -- macOS
      -- vim.fn.jobstart({"xdg-open", url})  -- Linux
      -- vim.fn.jobstart({"cmd", "/c", "start", url})  -- Windows
    end,
    picker = {
      name = "telescope.nvim",
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    
  end,
}
