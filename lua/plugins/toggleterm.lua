-- nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- [原有配置保持不变]
    })

    local toggleterm = require("toggleterm")
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- 使用 vim.tbl_extend 合并表
    map(
      "n",
      "<leader>tt",
      toggleterm.toggle,
      vim.tbl_extend("force", opts, {
        desc = "Toggle terminal",
      })
    )

    map(
      "n",
      "<leader>tf",
      function()
        toggleterm.toggle(1, 100, nil, "float")
      end,
      vim.tbl_extend("force", opts, {
        desc = "Toggle floating terminal",
      })
    )
  end,
}
