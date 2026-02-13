-- ===================== 自定义命令 =====================
-- 保存并返回 Dashboard
vim.api.nvim_create_user_command("WQ", function()
  vim.cmd("write")
  vim.cmd("Dashboard")
end, {})

-- Markdown 标题级别提升（#数量减少）
vim.api.nvim_create_user_command("Mdtitleup", function(o)
  vim.cmd(o.line1 .. "," .. o.line2 .. "s/^\\(#\\+\\)#\\s/\\1 /g")
  vim.notify("󰔵 标题级别已提升", vim.log.levels.INFO)
end, { range = true })

-- Markdown 标题级别降低（#数量增加）
vim.api.nvim_create_user_command("Mdtitledown", function(o)
  vim.cmd(o.line1 .. "," .. o.line2 .. "s/^\\(#\\+\\)\\s/\\1# /g")
  vim.notify("󰔳 标题级别已降低", vim.log.levels.INFO)
end, { range = true })
