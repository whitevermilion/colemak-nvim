-- plugins/mermaid.lua
return {
  "mracos/mermaid.vim",
  ft = { "markdown", "mermaid" }, -- 按文件类型加载
  config = function()
    -- 基础配置
    vim.g.mermaid_default_config = {
      startOnLoad = true,
      theme = "default",
      flowchart = {
        useMaxWidth = false,
        htmlLabels = true,
      },
    }

    -- 语法高亮
    vim.g.vim_mermaid_initialized = 1

    -- 快捷键映射
    vim.keymap.set("n", "<leader>mp", ":MermaidPreview<CR>", { desc = "Preview mermaid diagram" })
    vim.keymap.set("n", "<leader>ms", ":MermaidStop<CR>", { desc = "Stop mermaid preview" })
  end,
}
