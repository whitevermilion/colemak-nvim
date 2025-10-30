-- nvim/lua/plugins/ufo.lua
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
      provider_selector = function()
        return { "treesitter", "indent" }
      end,

      -- 添加预览功能
      preview = {
        win_config = {
          border = "single", -- 预览窗口边框样式
          winhighlight = "Normal:Folded", -- 预览窗口高亮
          winblend = 0, -- 透明度 (0-100)
        },
        mappings = {
          scrollU = "<C-k>", -- 向上滚动
          scrollD = "<C-j>", -- 向下滚动
          jumpTop = "[", -- 跳到顶部
          jumpBot = "]", -- 跳到底部
        },
      },

      -- 可选：启用虚拟文本（在折叠行显示摘要）
      enable_get_fold_virt_text = true,
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
