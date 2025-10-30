-- nvim/lua/plugins/nvim_treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- 安装语法解析器的语言列表，可以按需添加更多语言
        ensure_installed = {
          "c",
          "cpp",
          "lua",
          "javascript",
          "typescript",
          "python",
          "html",
          "css",
          "json",
          "bash",
          "markdown",
          "vim",
          "yaml",
        },

        -- 同步安装语言解析器，无需手动安装
        sync_install = false,

        -- 自动安装语法解析器
        auto_install = true,

        -- 高亮模块配置
        highlight = {
          enable = true, -- 启用语法高亮
          additional_vim_regex_highlighting = false, -- 是否使用额外的 Vim 正则表达式高亮
        },

        -- 代码缩进模块配置
        indent = {
          enable = true, -- 启用基于树突的缩进
        },

        -- 增量选择模块配置
        incremental_selection = {
          enable = true, -- 启用增量选择
          keymaps = {
            init_selection = "gnn", -- 初始化选择的快捷键
            node_incremental = "grn", -- 增量选择节点的快捷键
            scope_incremental = "grc", -- 增量选择作用域的快捷键
            node_decremental = "grm", -- 减量选择节点的快捷键
          },
        },

        -- 文本对象模块配置
        textobjects = {
          select = {
            enable = true, -- 启用文本对象选择
            lookahead = true, -- 是否启用预览功能
            keymaps = {
              -- 选择文本对象的快捷键配置
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true, -- 启用文本对象移动
            set_jumps = true, -- 是否记录跳转
            goto_next_start = {
              ["]m"] = "@function.outer", -- 跳转到下一个函数开头
              ["]]"] = "@class.outer", -- 跳转到下一个类开头
            },
            goto_next_end = {
              ["]M"] = "@function.outer", -- 跳转到下一个函数结尾
              ["]]"] = "@class.outer", -- 跳转到下一个类结尾
            },
            goto_previous_start = {
              ["[m"] = "@function.outer", -- 跳转到上一个函数开头
              ["[["] = "@class.outer", -- 跳转到上一个类开头
            },
            goto_previous_end = {
              ["[M"] = "@function.outer", -- 跳转到上一个函数结尾
              ["[]"] = "@class.outer", -- 跳转到上一个类结尾
            },
          },
        },
      })
    end,
  },
}
