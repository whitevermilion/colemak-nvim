-- markdown.lua (精简版)
vim.opt.conceallevel = 2

vim.keymap.set("n", "gx", function()
  local line = vim.fn.getline(".")
  local url = line:match("%[.-%]%((.-)%)")
  if url then
    vim.ui.open(url)
  else
    vim.cmd("normal! gx")
  end
end, { buffer = true, desc = "Open Markdown link" })
