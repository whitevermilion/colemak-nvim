-- nvim/lua/plugins/nvim_treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- 自动安装语言解析器
        ensure_installed = {
          "c",
          "cpp",
          "lua",
          "python",
          "html",
          "markdown",
          "vim",
          "yaml",
        },
        auto_install = true,
        sync_install = false,

        -- 核心功能：语法高亮和缩进
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },

        -- 只保留最实用的文本对象快捷键
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
          },
        },

        -- 增量选择（可选，保留基础功能）
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            node_decremental = "grm",
          },
        },

        -- 上下文感知功能（非常有用）
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = true,
  },
}
