return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",  -- 延迟加载提升启动速度
    config = function()
      -- 安全加载模块
      local ok, ufo = pcall(require, "ufo")
      if not ok then
        vim.notify("nvim-ufo not installed!", vim.log.levels.WARN)
        return
      end

      -- 基本设置：优化性能
      vim.opt.foldcolumn = "0"   -- 关闭折叠标记列（提升性能）
      vim.opt.foldlevel = 99     -- 默认打开所有折叠
      vim.opt.foldenable = true

      -- 高效初始化 UFO（使用最小配置）
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- 优先使用性能更好的折叠引擎
          if filetype == "markdown" or filetype == "text" then
            return { "indent" }  -- 对文本文件使用缩进折叠（更快）
          end
          return { "treesitter", "indent" }
        end
      })

      -- 优化折叠状态检测（避免全文件扫描）
      local function has_closed_folds()
        -- 只检查可见区域内的折叠状态
        local top = vim.fn.line("w0")
        local bottom = vim.fn.line("w$")
        for lnum = top, bottom do
          if vim.fn.foldclosed(lnum) > -1 then
            return true
          end
        end
        return false
      end

      -- zz: 切换当前行折叠（使用原生命令保持高效）
      vim.keymap.set("n", "zz", function()
        local lnum = vim.api.nvim_win_get_cursor(0)[1]
        if vim.fn.foldclosed(lnum) > -1 then
          vim.cmd("normal! zo")
        else
          vim.cmd("normal! zc")
        end
      end, { desc = "Toggle current fold" })

      -- za: 切换所有折叠（使用UFO API）
      vim.keymap.set("n", "za", function()
        if has_closed_folds() then
          ufo.openAllFolds()
        else
          ufo.closeAllFolds()
        end
      end, { desc = "Toggle all folds" })
    end
  }
}
