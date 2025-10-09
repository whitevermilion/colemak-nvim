return {
  -- rainbow-delimiters.nvim - 彩虹括号
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      -- 配置彩虹括号
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          -- 彩虹色配置（你可以自定义这些颜色）
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        -- 黑名单文件类型（不需要彩虹括号的文件类型）
        blacklist = {'help', 'terminal', 'dashboard', 'packer', 'lazy'},
      })

      -- 可选：自定义高亮颜色（如果你想要特定的颜色）
      vim.cmd([[
        highlight RainbowDelimiterRed guifg=#ff6b6b
        highlight RainbowDelimiterYellow guifg=#feca57
        highlight RainbowDelimiterBlue guifg=#48dbfb
        highlight RainbowDelimiterOrange guifg=#ff9f43
        highlight RainbowDelimiterGreen guifg=#1dd1a1
        highlight RainbowDelimiterViolet guifg=#f368e0
        highlight RainbowDelimiterCyan guifg=#0abde3
      ]])
    end,
  },
}
