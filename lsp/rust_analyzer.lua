-- ~/.config/nvim/lsp/rust_analyzer.lua
return {
  name = "rust_analyzer",
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = function(fname)
    -- 使用 vim.fs.find 替代 lspconfig.util.root_pattern
    local found = vim.fs.find("Cargo.toml", { path = fname, upward = true })[1]
    if found then return vim.fs.dirname(found) end
  end,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
