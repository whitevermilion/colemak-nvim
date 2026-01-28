-- ~/.config/nvim/lua/plugins/marks.lua
return {
  "chentoast/marks.nvim",
  event = "BufReadPost",
  opts = {
    default_mappings = true,
    -- 启用内置标记
    builtin_marks = { ".", "<", ">", "^" },
    -- 启用书签0-9
    bookmark_0 = { sign = "⚑" },
    cyclic = true,
  },
}
