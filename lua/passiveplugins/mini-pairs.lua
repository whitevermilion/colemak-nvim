  -- ========================
  -- 自动配对 (mini.pairs) - 增强版
  -- ========================
return {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
        
        -- 智能跳过规则
        skip_next = "[%w%%%'%[%\"%.%`%$]",  -- 遇到这些字符不自动配对
        skip_ts = { "string", "comment" },   -- 在字符串和注释中禁用
        
        -- 特殊文件类型处理
        filetypes = {
          ["markdown"] = { skip_next = "[%w%(%{%[%\"%.%`%$]" },
          ["tex"] = { skip_next = "[%w%\\%(%{%[%\"%.%`%$]" }
        },
        
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
          ["'"] = { action = "open", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ['"'] = { action = "open", pair = '""', neigh_pattern = '[^%a\\].', register = { cr = false } },
          ["`"] = { action = "open", pair = "``", neigh_pattern = "[^\\]." },
        }
      })
    end
}
