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

    note_id_func = function(title) return title:gsub(" ", "-"):lower() end,

    preferred_link_style = "wiki",

    ui = {
      enable = true,
      disable = {
        "outline",
        "backlinks",
        "hover",
      },
    },

    follow_url_func = function(url) vim.fn.jobstart({ "open", url }) end,
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    -- 设置 markdown 文件的 conceallevel
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function() vim.opt_local.conceallevel = 1 end,
    })

    vim.keymap.set("n", "<CR>", function() end, { expr = true, desc = "跳转链接或新建行" })
  end,
}
