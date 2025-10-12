return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {
    -- 禁用光标行的高亮/取消渲染
    highlight = {
      cursor_line = false, -- 关键设置：禁用光标行的特殊处理
    },
    -- 标题样式调整：使用更简洁的符号
    headings = {
      enabled = true,
      level = 6,
      icons = { "➤ ", "➤ ", "➤ ", "• ", "• ", "• " },
    },

    -- 代码块样式
    code_blocks = {
      enabled = true,
      border = "false",
      line_number = true,
      highlight_current_line = true,
      show_language = true,
      hide_ticks = true,
    },

    -- 列表符号调整
    list_chars = {
      unordered = "•",
    },

    -- 禁用特定元素的渲染
    bold = {
      enabled = false,
    },
    italic = {
      enabled = false,
    },

    -- 链接渲染
    links = {
      enabled = true,
      format = "plain",
    },

    -- 表格渲染
    tables = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- 为 Markdown 文件设置特殊的代码块导航
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- 向下移动，如果下一行是代码块标记则跳过两行
        vim.keymap.set("n", "n", function()
          local current_line = vim.fn.line(".")
          local next_line = vim.fn.getline(current_line + 1)

          -- 检查下一行是否是代码块标记
          if next_line and next_line:match("^```") then
            -- 跳过代码块标记，移动两行
            vim.cmd("normal! 2j")
          else
            -- 正常移动一行
            vim.cmd("normal! j")
          end
        end, { buffer = true, desc = "向下移动，跳过代码块标记" })

        -- 向上移动，如果上一行是代码块标记则跳过两行
        vim.keymap.set("n", "e", function()
          local current_line = vim.fn.line(".")
          local prev_line = vim.fn.getline(current_line - 1)

          -- 检查上一行是否是代码块标记
          if prev_line and prev_line:match("^```") then
            -- 跳过代码块标记，移动两行
            vim.cmd("normal! 2k")
          else
            -- 正常移动一行
            vim.cmd("normal! k")
          end
        end, { buffer = true, desc = "向上移动，跳过代码块标记" })
      end,
    })
  end,
}
