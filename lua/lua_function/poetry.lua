-- lua/lua_function/poetry.lua
local M = {}

local poetry_library = {
  daytime = {
    "我是人间惆怅客，知君何事泪纵横。断肠声里忆平生。",
    "人生若只如初见，何事秋风悲画扇。",
    "海内存知己，天涯若比邻。",
  },
  nighttime = {
    "书似青山常堆叠，灯如红豆最相思",
    "月落乌啼霜满天，江枫渔火对愁眠。",
    "星垂平野阔，月涌大江流。",
    "我本可以忍受黑暗，如果我不曾见过光明，\n可如今阳光把我的孤独照耀的更加荒凉。",
  },
}

function M.setup()
  -- 等待 notify 完全加载后直接设置命令
  vim.api.nvim_create_autocmd("User", {
    pattern = "ActuallyLoaded",
    once = true,
    callback = function()
      -- 启动诗词
      vim.defer_fn(function()
        local current_hour = tonumber(os.date("%H"))
        local time_type = (current_hour >= 7 and current_hour < 19) and "daytime" or "nighttime"
        local poems = poetry_library[time_type]
        local poem = poems[math.random(1, #poems)]
        vim.notify(poem, vim.log.levels.INFO, {
          timeout = 5000,
        })
      end, 500)

      -- 简化的诗词命令
      vim.api.nvim_create_user_command("Poem", function()
        local current_hour = tonumber(os.date("%H"))
        local time_type = (current_hour >= 7 and current_hour < 19) and "daytime" or "nighttime"
        local poems = poetry_library[time_type]
        local poem = poems[math.random(1, #poems)]
        vim.notify(poem, vim.log.levels.INFO, {
          timeout = 5000,
        })
      end, { desc = "显示随机诗词" })

      vim.api.nvim_create_user_command("PoemDay", function()
        local poems = poetry_library.daytime
        local poem = poems[math.random(1, #poems)]
        vim.notify(poem, vim.log.levels.INFO, {
          timeout = 5000,
        })
      end, { desc = "显示白天诗词" })

      vim.api.nvim_create_user_command("PoemNight", function()
        local poems = poetry_library.nighttime
        local poem = poems[math.random(1, #poems)]
        vim.notify(poem, vim.log.levels.INFO, {
          timeout = 5000,
        })
      end, { desc = "显示夜间诗词" })
    end,
  })
end

return M
