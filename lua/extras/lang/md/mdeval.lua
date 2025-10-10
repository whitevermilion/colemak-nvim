return {
  "jubnzv/mdeval.nvim",
  ft = { "markdown" },
  config = function()
    require('mdeval').setup({
      require_confirmation = false,  -- 禁用执行确认
    })
    
    vim.keymap.set("n", "<leader>er", "<cmd>MdEval<CR>", {
      desc = "执行当前代码块"
    })
  end,
}
