return {
  "mzlogin/vim-markdown-toc",
  ft = "markdown",
  config = function()
    -- 设置自动更新目录
    vim.g.vmt_auto_update_on_save = 1
    vim.g.vmt_dont_insert_fence = 0
    vim.g.vmt_cycle_list_item_markers = 1
    vim.g.vmt_fence_text = "TOC"
    vim.g.vmt_fence_closing_text = "/TOC"

    -- 将 MarkdownToc 命令作为 GenTocGFM 的别名
    vim.api.nvim_create_user_command("MarkdownToc", "GenTocGFM", {})
  end,
}
