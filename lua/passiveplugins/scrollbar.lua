return {
  "petertriho/nvim-scrollbar",
  dependencies = {
    "kevinhwang91/nvim-hlslens"
    },
  config = function()
    local scrollbar = require("scrollbar")
    
    scrollbar.setup({
      handle = {
        color = "#3e4452",  -- 滚动条手柄颜色
        blend = 30,         -- 透明度混合 (0-100)
      },
      marks = {
        Search = { color = "#ff9e64" },  -- 搜索高亮标记颜色
        Error = { color = "#e06c75" },   -- 错误标记颜色
        Warn = { color = "#e5c07b" },    -- 警告标记颜色
        Info = { color = "#61afef" },    -- 信息标记颜色
        Hint = { color = "#98c379" },    -- 提示标记颜色
      },
      excluded_filetypes = {  -- 排除的文件类型
        "prompt",
        "TelescopePrompt",
        "NvimTree",
      },
      handlers = {  -- 事件处理器
        diagnostic = true,   -- 显示诊断标记
        search = true,       -- 显示搜索标记
        gitsigns = false,    -- 是否显示 git 标记 (需要 nvim-gitsigns)
      },
    })
    
  end
}
