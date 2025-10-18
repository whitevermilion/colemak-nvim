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

    -- 简化的命令：在当前光标位置插入标记并生成目录
    vim.api.nvim_create_user_command("MarkdownToc", function()
      -- 获取当前光标位置
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      local current_line = cursor_pos[1] - 1 -- 转换为0-based索引

      -- 在当前光标位置插入标记
      vim.api.nvim_buf_set_lines(0, current_line, current_line, false, {
        "<!-- TOC GFM -->",
        "<!-- /TOC -->",
        "",
        "---",
      })

      -- 生成目录
      vim.cmd("GenTocGFM")

      print("TOC generated successfully!")
    end, {})
  end,
}
