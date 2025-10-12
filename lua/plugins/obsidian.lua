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
    -- 极简配置：只启用核心功能
    ui = {
      enable = true,
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- 为 markdown 文件设置 conceallevel（必需）
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.conceallevel = 1
        vim.opt_local.wrap = false -- 代码块内不换行
        vim.opt_local.spell = false
      end,
    })

    -- 唯一的核心功能：智能 Enter 跳转
    vim.keymap.set("n", "<CR>", function()
      local line = vim.fn.getline(".")
      local col = vim.fn.col(".")
      local char = line:sub(col, col)

      -- 如果光标在链接上，跳转；否则正常换行
      if char == "]" or char == ")" or line:match("%[%[.*%]%]") then
        return require("obsidian").util.gf_passthrough()
      else
        return "o"
      end
    end, { expr = true, desc = "跳转链接或新建行" })
  end,
}
