return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
      local ok, ufo = pcall(require, "ufo")
      if not ok then
        vim.notify("nvim-ufo not installed!", vim.log.levels.WARN)
        return
      end

      vim.opt.foldcolumn = "0"
      vim.opt.foldlevel = 99
      vim.opt.foldenable = true

      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          if filetype == "markdown" then
            return { "treesitter", "indent" }
          end
          return { "treesitter", "indent" }
        end,
      })

      -- 为 markdown 文件设置 treesitter 折叠和 conceallevel
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.wo.foldmethod = "expr" -- 使用 vim.wo 设置窗口选项
          vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt_local.conceallevel = 1 -- 在这里统一设置 conceallevel
          vim.opt_local.wrap = false
          vim.opt_local.spell = false
        end,
      })

      -- 只使用 zz 作为切换折叠的快捷键
      vim.keymap.set("n", "zz", function()
        local lnum = vim.api.nvim_win_get_cursor(0)[1]
        if vim.fn.foldclosed(lnum) > -1 then
          vim.cmd("normal! zo")
        else
          local foldlevel = vim.fn.foldlevel(lnum)
          if foldlevel > 0 then
            vim.cmd("normal! zc")
          else
            vim.cmd("normal! za")
          end
        end
      end, { desc = "Toggle fold" })
    end,
  },
}
