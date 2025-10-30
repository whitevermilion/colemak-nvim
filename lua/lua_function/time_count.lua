-- nvim/lua/lua_function/teme_count.lua
-- 超简使用时间追踪（修复版）
local M = {}

local file = vim.fn.stdpath("data") .. "/nvim_time.json"

-- 读取数据（简化错误处理）
local function load()
  if vim.fn.filereadable(file) == 1 then
    local data = vim.fn.readfile(file)
    if #data > 0 then
      return vim.json.decode(data[1]) or { total = 0 }
    end
  end
  return { total = 0 }
end

-- 保存数据
local function save(data)
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
  vim.fn.writefile({ vim.json.encode(data) }, file)
end

function M.setup()
  -- 启动记录
  local start_time = os.time()
  local old_data = load()

  -- 退出时保存
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      local duration = os.time() - start_time
      old_data.total = (old_data.total or 0) + duration
      save(old_data)
      print(string.format("本次使用: %d分钟", math.floor(duration / 60)))
    end,
  })

  -- 显示统计命令
  vim.api.nvim_create_user_command("Mytime", function()
    local data = load()
    local total_hours = math.floor((data.total or 0) / 3600)
    local total_minutes = math.floor(((data.total or 0) % 3600) / 60)
    print(string.format("总使用: %d小时%d分钟", total_hours, total_minutes))
  end, {})
end

return M
