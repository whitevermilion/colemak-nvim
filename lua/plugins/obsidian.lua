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
      enable = true,
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- 移除重复的 conceallevel 设置，因为已经在 ufo.lua 中统一设置了
    -- 只保留智能 Enter 跳转功能
    vim.keymap.set("n", "<CR>", function()
      local line = vim.fn.getline(".")
      local col = vim.fn.col(".")
      local char = line:sub(col, col)

      if char == "]" or char == ")" or line:match("%[%[.*%]%]") then
        return require("obsidian").util.gf_passthrough()
      else
        return "o"
      end
    end, { expr = true, desc = "跳转链接或新建行" })
  end,
}
