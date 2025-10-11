-- mdeval.lua
local M = {}

-- 模板配置
M.template_config = {
  c = {
    path = "~/.config/nvim/lua/extras/lang/c/c-template.c",
    block_type = "c",
    name = "C"
  },
  cpp = {
    path = "~/.config/nvim/lua/extras/lang/cpp/cpp-template.cpp",
    block_type = "cpp", 
    name = "C++"
  }
  -- 可以在这里添加更多语言模板
  -- python = {
  --   path = "~/.config/nvim/lua/extras/lang/python/python-template.py",
  --   block_type = "python",
  --   name = "Python"
  -- }
}

-- 插入模板的主函数
function M.insert_code_template(language)
  local config = M.template_config[language]
  if not config then
    vim.notify("不支持的语言: " .. language, vim.log.levels.ERROR)
    return
  end
  
  local template_path = vim.fn.expand(config.path)
  
  -- 检查文件是否存在
  if vim.fn.filereadable(template_path) == 0 then
    vim.notify("模板文件不存在: " .. template_path, vim.log.levels.ERROR)
    return
  end
  
  -- 读取模板文件
  local template_content = vim.fn.readfile(template_path)
  
  -- 构建代码块
  local code_block = {"```" .. config.block_type}
  for _, line in ipairs(template_content) do
    table.insert(code_block, line)
  end
  table.insert(code_block, "```")
  
  -- 获取当前光标位置
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  
  -- 插入模板内容
  vim.api.nvim_buf_set_lines(0, current_line, current_line, false, code_block)
  
  -- 智能定位光标到编辑位置
  M.position_cursor(current_line, code_block, language)
  
  vim.notify(config.name .. " 模板已插入", vim.log.levels.INFO)
end

-- 光标定位函数
function M.position_cursor(start_line, code_block, language)
  -- 寻找 main 函数或类似的入口点
  for i, line in ipairs(code_block) do
    if line:match("int main%(") or           -- C/C++ main 函数
       line:match("def main%(") or           -- Python main 函数  
       line:match("public static void main%(") then -- Java main 方法
      local target_line = start_line + i + 1  -- 移动到函数内部
      vim.api.nvim_win_set_cursor(0, {target_line, 4})
      return
    end
  end
  
  -- 如果没有找到特定模式，默认定位到代码块中间
  local default_line = start_line + math.floor(#code_block / 2)
  vim.api.nvim_win_set_cursor(0, {default_line, 4})
end

-- 初始化函数
function M.setup()
  require('mdeval').setup({
    require_confirmation = false,
  })
  
  -- 执行当前代码块
  vim.keymap.set("n", "<leader>er", "<cmd>MdEval<CR>", {
    desc = "执行当前代码块"
  })
  
  -- 设置模板插入快捷键
  vim.keymap.set("n", "<leader>pcp", function()
    M.insert_code_template("cpp")
  end, {
    desc = "插入C++代码模板"
  })
  
  vim.keymap.set("n", "<leader>pcc", function()
    M.insert_code_template("c")
  end, {
    desc = "插入C代码模板"
  })
end

return {
  "jubnzv/mdeval.nvim",
  ft = { "markdown" },  -- 只在 .md 文件加载，优化启动速度
  config = M.setup
}
