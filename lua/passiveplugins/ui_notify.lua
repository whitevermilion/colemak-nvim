return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require("notify")
    notify.setup({
      timeout = 5000,
      max_width = 60,
      stages = "fade_in_slide_out",
      -- render = "minimal",
      level = "info",
      background_colour = "#1e222a",
      icons = {
        ERROR = "Error（>﹏<）",
        WARN = "Warn(・□・;)!",
        INFO = "Info（´▽｀）",
        DEBUG = "Debug（‘・ω・）?",
        TRACE = "Trace（・-・）",
      },
    })
    vim.notify = notify

    -- 触发自定义事件，通知其他插件 notify 已加载
    vim.api.nvim_exec_autocmds("User", { pattern = "ActuallyLoaded" })
  end,
}
