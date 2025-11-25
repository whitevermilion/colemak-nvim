-- nvim/lua/passiveplugins/rainbow_delimiters.lua
return {
  -- rainbow-delimiters.nvim - 彩虹括号
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      -- 配置彩虹括号
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          -- 彩虹色配置（你可以自定义这些颜色）
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        -- 黑名单文件类型（不需要彩虹括号的文件类型）
        blacklist = { "help", "terminal", "dashboard", "packer", "lazy" },
      })
    end,
  },
}
