local M = {}

-- 通用头部配置
local function get_header()
  local default_header = [[
░  ░░░░░░░░  ░░░░  ░░░      ░░░  ░░░░░░░
▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒
▓  ▓▓▓▓▓▓▓▓        ▓▓  ▓▓▓▓▓▓▓▓       ▓▓
█  ████████  ████  ██  ████  ██  ████  █
█        ██  ████  ███      ███       ██
  ]]

  -- 智能检测工作环境
  local cwd = vim.fn.getcwd(0)
  if cwd then
    -- 检测笔记类目录
    if cwd:find("Obsidian") or cwd:find("notes") or cwd:find("vault") or cwd:find("wiki") then
      return [[
                   ----                 
                --------                
              ----------  --            
           ------------  -----          
        -------------   -------         
       -------------   ----------       
       ------------   ------------      
       ------------  -------------      
        -----------  -------------      
      -   ---------  --------------     
     ----  --------  --------------     
    ------   ------   ---------------   
   --------   -----     --------------  
  ----------      ------     -----------
 ------------  --------------   --------
-------------  ----------------   ----  
 ------------  ------------------  --   
   ----------  -------------------      
      ------  --------------------      
        ---   -------------------       
            ---------------------       
                       ---------        
      ]]
    end

    -- 检测代码项目
    if cwd:find("src") or cwd:find("project") or cwd:find("code") then
      return [[
    ╭──────────────────────────────────────────╮
    │              CODE WORKSPACE              │
    ╰──────────────────────────────────────────╯
      ]]
    end
  end

  return default_header
end

M.setup = {
  notifier = {},
  picker = {
    matcher = {
      frecency = true, -- 基于使用频率和新鲜度排序
      cwd_bonus = true, -- 当前目录文件有加分
      history_bonus = true, -- 历史记录文件有加分
    },
    formatters = {
      icon_width = 3, -- 文件图标宽度
    },
  },
  dashboard = {
    preset = {
      keys = {
        { icon = "󰈞 ", key = "f", desc = "Find files", action = ":lua Snacks.picker.smart()" },
        { icon = " ", key = "h", desc = "Find history", action = ":lua Snacks.picker.recent()" },
        { icon = " ", key = "n", desc = "New file", action = ":enew" },
        { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        {
          icon = "󰔛 ",
          key = "P",
          desc = "Lazy Profile",
          action = ":Lazy profile",
          enabled = package.loaded.lazy ~= nil,
        },
        { icon = " ", key = "M", desc = "Mason", action = ":Mason", enabled = package.loaded.mason ~= nil },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = get_header(),
    },
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
    },
  },
  image = {
    enabled = true,
    doc = {
      enabled = true,
      inline = false,
      float = true,
      max_width = 80,
      max_height = 20,
    },
    -- 通用的图像路径解析（可根据需要取消注释和修改）
    -- resolve = function(_, src)
    --   -- 在这里添加你的图像路径解析逻辑
    --   -- 例如：将相对路径转换为绝对路径
    --   if not src:match '^/' then
    --     return vim.fn.getcwd() .. '/' .. src
    --   end
    --   return src
    -- end,
  },
  indent = {
    enabled = false,
    indent = { enabled = false },
    animate = { duration = { step = 10, duration = 100 } },
    scope = {
      enabled = true,
      char = "┊",
      underline = false,
      only_current = true,
      priority = 1000,
    },
  },
  styles = {
    snacks_image = {
      border = "rounded",
      backdrop = false,
    },
  },
}

-- 可选：添加一些快捷键
-- vim.keymap.set('n', '<leader>ss', '<cmd>lua Snacks.picker.smart()<cr>', { desc = 'Snacks: Smart file picker' })
-- vim.keymap.set('n', '<leader>sr', '<cmd>lua Snacks.picker.recent()<cr>', { desc = 'Snacks: Recent files' })
-- vim.keymap.set('n', '<leader>sd', '<cmd>lua Snacks.dashboard.toggle()<cr>', { desc = 'Snacks: Dashboard' })

return M
