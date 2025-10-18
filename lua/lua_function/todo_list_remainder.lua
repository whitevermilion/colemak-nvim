-- lua/lua_function/todo_list_remainder.lua
local M = {}

-- 待办事项文件路径
local todo_file_path = vim.fn.expand("~/.config/nvim/lua/extras/todo_list/todo_list.md")

function M.setup()
  -- 等待 Neovim 完全加载后执行
  vim.api.nvim_create_autocmd("User", {
    pattern = "ActuallyLoaded",
    once = true,
    callback = function()
      vim.defer_fn(function()
        M.show_todo_list()
      end, 800) -- 延迟显示
    end,
  })

  -- 编辑命令
  vim.api.nvim_create_user_command("Todo", function()
    M.edit_todo_file()
  end, { desc = "编辑待办事项文件" })
end

-- 显示待办事项
function M.show_todo_list()
  local file = io.open(todo_file_path, "r")
  if not file then
    -- 文件不存在也显示"今日无事"
    vim.notify("今日无事", vim.log.levels.INFO, {
      title = "待办事项",
      timeout = 3000, -- 3秒后自动关闭
    })
    return
  end

  local content = file:read("*a")
  file:close()

  -- 移除空行和多余空格
  content = content:gsub("\n+", "\n"):gsub("^%s+", ""):gsub("%s+$", "")
  --[[
  if content == "" then
    -- 内容为空时显示"今日无事"
    vim.notify("今日无事", vim.log.levels.INFO, {
      title = "待办事项",
      timeout = 3000, -- 3秒后自动关闭
    })
    return
  end
    ]]
  -- 简洁显示待办事项
  vim.notify(content, vim.log.levels.INFO, {
    title = "待办事项",
    timeout = 5000, -- 5秒后自动关闭
  })
end

-- 编辑待办事项文件
function M.edit_todo_file()
  vim.cmd("edit " .. todo_file_path)
end

return M
