return {
  -- ========================
  -- 自动配对 (mini.pairs) - 增强版
  -- ========================
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
        
        -- 智能跳过规则
        skip_next = "[%w%%%'%[%\"%.%`%$]",  -- 遇到这些字符不自动配对
        skip_ts = { "string", "comment" },   -- 在字符串和注释中禁用
        
        -- 特殊文件类型处理
        filetypes = {
          ["markdown"] = { skip_next = "[%w%(%{%[%\"%.%`%$]" },
          ["tex"] = { skip_next = "[%w%\\%(%{%[%\"%.%`%$]" }
        },
        
        -- 自定义配对映射 - 添加了 <> 配对
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
          ["'"] = { action = "open", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ['"'] = { action = "open", pair = '""', neigh_pattern = '[^%a\\].', register = { cr = false } },
          ["`"] = { action = "open", pair = "``", neigh_pattern = "[^\\]." },
        }
      })
    end
  },

  -- ========================
  -- 智能注释 (ts-comments.nvim)
  -- ========================
  {
    "folke/ts-comments.nvim",
    keys = {
      { "gcc", desc = "Toggle line comment" },  -- 行注释
      { "gc", mode = { "x" }, desc = "Comment selection" },  -- 仅可视模式
      { "gbc", desc = "Toggle block comment" },  -- 块注释 (使用 gbc 避免冲突)
      { "gcd", desc = "Toggle doc comment" }     -- 文档注释
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("ts-comments").setup({
        -- 语言特定配置
        lang = {
          lua = {
            line = "--",
            block = { left = "--[[", right = "]]" },
            doc = { left = "---", right = "" }
          },
          python = {
            line = "#",
            block = { left = '"""', right = '"""' },
            doc = { left = '"""', right = '"""' }
          },
          cpp = {
            line = "//",
            block = { left = "/*", right = "*/" },
            doc = { left = "/*!", right = "*/" }
          },
          javascript = {
            line = "//",
            block = { left = "/*", right = "*/" },
            doc = { left = "/**", right = "*/" }
          }
        },
        
        -- 上下文感知配置
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
          config = {
            typescript = "// %s",
            css = "/* %s */",
            scss = "/* %s */",
            html = "<!-- %s -->",
            vue = "<!-- %s -->",
            svelte = "<!-- %s -->"
          }
        },
        
        -- 高级功能
        padding = true,          -- 注释后添加空格
        sticky = true,           -- 光标保持在注释位置
        enable_doc_comment = true -- 自动生成文档注释
      })
      
      vim.keymap.del("n", "gc")

      -- 增强键位：切换注释类型
      vim.keymap.set("n", "gbc", function()
        require("ts-comments").toggle_block()  -- 使用模块级函数
      end, { desc = "Toggle block comment" })
      
      -- 文档注释快捷键
      vim.keymap.set("n", "gcd", function()
        require("ts-comments").toggle_doc()  -- 使用模块级函数
      end, { desc = "Toggle doc comment" })
    end
  },
}
