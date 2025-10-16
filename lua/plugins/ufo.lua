return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  config = function()
    -- 基础折叠设置
    vim.opt.foldcolumn = "0"
    vim.opt.foldlevel = 99
    vim.opt.foldenable = true

    require("ufo").setup({
      provider_selector = function(_, filetype)
        return { "treesitter", "indent" }
      end,
    })

    -- 简化后的折叠切换快捷键
    vim.keymap.set("n", "zz", function()
      local lnum = vim.api.nvim_win_get_cursor(0)[1]
      local closed = vim.fn.foldclosed(lnum)

      if closed > -1 then
        vim.cmd("normal! zo")
      else
        vim.cmd("normal! za")
      end
    end, { desc = "Toggle fold" })
  end,
}
