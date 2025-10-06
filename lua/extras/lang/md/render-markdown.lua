return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {
    -- 标题样式调整：使用更简洁的符号
    headings = {
      enabled = true,
      level = 6,
      -- 尝试不同的标题符号
      icons = { "➤ ", "➤ ", "➤ ", "• ", "• ", "• " }, -- 更简洁的符号
      -- 或者完全禁用标题图标，使用纯文本
      -- use_icons = false,
    },
    
    -- 代码块样式
    code_blocks = {
      enabled = true,
      -- 简化代码块边框
      border = "single", -- 或者 "double", "rounded", "none"
    },
    
    -- 列表符号调整
    list_chars = {
      unordered = "•", -- 使用简单的圆点
      -- unordered = "-", -- 或者使用传统的短横线
    },
    
    -- 禁用特定元素的渲染
    bold = {
      enabled = false, -- 如果你不喜欢粗体渲染
    },
    italic = {
      enabled = false, -- 如果你不喜欢斜体渲染  
    },
    
    -- 链接渲染
    links = {
      enabled = true,
      format = "plain", -- 改为 "plain" 显示原始链接
    },
    
    -- 表格渲染
    tables = {
      enabled = false, -- 如果表格渲染效果不好，可以禁用
    }
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)
  end,
}
