-- 统一图标定义（同时用于两个插件）
local icon_definitions = {
  -- 文件类型图标
  file = {
    ["makefile"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    ["cmakelists.txt"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    [".clang-format"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    [".clang-tidy"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    [".gitignore"] = { icon = "", color = "#F14C28", cterm_color = "166" },
    ["dockerfile"] = { icon = "", color = "#2496ED", cterm_color = "33" },
    ["package.json"] = { icon = "", color = "#F0DB4F", cterm_color = "227" },
    ["pyproject.toml"] = { icon = "", color = "#FFD43B", cterm_color = "220" },
    ["cargo.toml"] = { icon = "", color = "#F74C00", cterm_color = "202" },
    ["go.mod"] = { icon = "", color = "#00ADD8", cterm_color = "38" }
  },
  
  -- 文件扩展名图标
  extension = {
    -- C/C++
    ["c"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    ["cpp"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    ["cc"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    ["cxx"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    ["h"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    ["hpp"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    ["hxx"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    ["inl"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    ["ii"] = { icon = "", color = "#519ABA", cterm_color = "67" },
    
    -- 构建系统
    ["cmake"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    ["make"] = { icon = "", color = "#6D8086", cterm_color = "66" },
    
    -- 编程语言
    ["lua"] = { icon = "", color = "#000080", cterm_color = "18" },
    ["py"] = { icon = "", color = "#FFD43B", cterm_color = "220" },
    ["js"] = { icon = "", color = "#F0DB4F", cterm_color = "227" },
    ["ts"] = { icon = "", color = "#3178C6", cterm_color = "26" },
    ["html"] = { icon = "", color = "#E44D26", cterm_color = "166" },
    ["css"] = { icon = "", color = "#264DE4", cterm_color = "26" },
    ["rs"] = { icon = "", color = "#F74C00", cterm_color = "202" },
    ["go"] = { icon = "", color = "#00ADD8", cterm_color = "38" },
    ["sh"] = { icon = "", color = "#4EAA25", cterm_color = "28" },
    ["zsh"] = { icon = "", color = "#4EAA25", cterm_color = "28" },
    
    -- 配置文件
    ["conf"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["cfg"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["ini"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["yml"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["yaml"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["toml"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["json"] = { icon = "", color = "#F0DB4F", cterm_color = "227" },
    
    -- 文档
    ["md"] = { icon = "", color = "#42A5F5", cterm_color = "33" },
    ["markdown"] = { icon = "", color = "#42A5F5", cterm_color = "33" },
    ["txt"] = { icon = "", color = "#CCCCCC", cterm_color = "251" },
    ["pdf"] = { icon = "", color = "#D32F2F", cterm_color = "160" }
  },
  
  -- 目录图标
  directory = {
    -- 代码相关目录
    ["src"] = "",
    ["source"] = "",
    ["include"] = "",
    ["lib"] = "",
    ["build"] = "",
    ["dist"] = "",
    ["bin"] = "",
    ["tests"] = "",
    ["test"] = "",
    
    -- 版本控制
    [".git"] = "",
    [".github"] = "",
    [".vscode"] = "",
    [".idea"] = "",
    
    -- 语言特定
    ["node_modules"] = "",
    ["venv"] = "",
    ["env"] = ""
  }
}

-- 将完整定义转换为 mini.icons 需要的简化格式
local function get_mini_icons_mappings()
  local mappings = {
    file = {},
    extension = {},
    directory = icon_definitions.directory
  }
  
  for name, data in pairs(icon_definitions.file) do
    mappings.file[name] = data.icon
  end
  
  for ext, data in pairs(icon_definitions.extension) do
    mappings.extension[ext] = data.icon
  end
  
  return mappings
end

return {
  -- nvim-web-devicons 配置
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      local devicons = require("nvim-web-devicons")
      
      -- 设置文件图标
      for filename, data in pairs(icon_definitions.file) do
        devicons.set_icon({
          name = filename,
          icon = data.icon,
          color = data.color,
          cterm_color = data.cterm_color
        })
      end
      
      -- 设置扩展名图标
      for ext, data in pairs(icon_definitions.extension) do
        devicons.set_icon({
          name = "*." .. ext,
          icon = data.icon,
          color = data.color,
          cterm_color = data.cterm_color
        })
      end
    end
  },
  
  -- mini.icons 配置
  {
    "echasnovski/mini.icons",
    event = "VeryLazy",
    config = function()
      require("mini.icons").setup({
        mappings = get_mini_icons_mappings()
     })
    end
  }
}
