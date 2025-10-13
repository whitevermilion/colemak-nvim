-- lua/extras/manager.lua
local M = {}

function M.toggle_comment(module_name)
  local config_file = vim.fn.stdpath("config") .. "/lua/extras/extras_list.lua"
  local content = vim.fn.readfile(config_file)

  -- 构建匹配模式：查找包含模块名的导入行
  local pattern = "import.*" .. module_name

  for i, line in ipairs(content) do
    if line:match(pattern) then
      if line:match("^%s*%-%-") then
        -- 取消注释
        content[i] = line:gsub("^%s*%-%-%s*", "")
        vim.notify("已启用: " .. module_name)
      else
        -- 添加注释
        content[i] = "-- " .. line
        vim.notify("已禁用: " .. module_name)
      end
      break
    end
  end

  vim.fn.writefile(content, config_file)
  vim.notify("请运行 :Lazy reload 应用更改")
end

-- 新增：显示所有模块状态
function M.show_status()
  local config_file = vim.fn.stdpath("config") .. "/lua/extras/extras_list.lua"
  local content = vim.fn.readfile(config_file)

  -- 定义模块列表和对应的显示名称
  local modules = {
    { key = "dap", name = "调试功能 (DAP)" },
    { key = "c", name = "C 语言支持" },
    { key = "md", name = "Markdown 增强" },
    { key = "ai", name = "AI 编程助手" },
    { key = "todo-list", name = "任务管理" },
  }

  -- 收集状态信息
  local status_lines = {}
  table.insert(status_lines, "=== Extras 模块状态 ===")

  for _, module in ipairs(modules) do
    local enabled = false
    local pattern = "import.*" .. module.key

    for _, line in ipairs(content) do
      if line:match(pattern) and not line:match("^%s*%-%-") then
        enabled = true
        break
      end
    end

    local status = enabled and "✅ 已启用" or "❌ 已禁用"
    table.insert(status_lines, string.format("%s: %s", module.name, status))
  end

  table.insert(status_lines, "========================")
  table.insert(status_lines, "使用 :ExtrasToggle <模块名> 切换状态")
  table.insert(status_lines, "使用 :ExtrasEdit 手动编辑配置")

  -- 显示状态
  print(table.concat(status_lines, "\n"))
end

function M.setup()
  -- 切换模块命令
  vim.api.nvim_create_user_command("ExtrasToggle", function(opts)
    M.toggle_comment(opts.args)
  end, { nargs = 1, desc = "切换功能模块" })

  -- 编辑配置文件的命令
  vim.api.nvim_create_user_command("ExtrasEdit", function()
    vim.cmd("edit ~/.config/nvim/lua/extras/extras_list.lua")
  end, { desc = "编辑 Extras 配置" })

  -- 新增：显示状态命令
  vim.api.nvim_create_user_command("ExtrasStatus", function()
    M.show_status()
  end, { desc = "显示 Extras 模块状态" })
end

return M
