return {
  "xiyaowong/nvim-transparent",
  config = function()
    require("transparent").setup({
      enable = true, -- 默认启用透明
      extra_groups = {
        "NormalFloat", -- 浮动窗口
        "NvimTreeNormal", -- NvimTree
        "TelescopeNormal", -- Telescope
        "WhichKeyFloat", -- WhichKey
        "Pmenu", -- 补全菜单
        --"PmenuSel", -- 选中项（可选）
        --"CursorLine", -- 光标所在行（可选）
        --"CursorColumn", -- 光标所在列（可选）
      },
      exclude_groups = {}, -- 不透明的组
    })
  end,
}
