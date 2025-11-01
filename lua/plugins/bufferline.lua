-- nvim/lua/plugins/bufferline.lua
return {
  -- bufferline.nvim - 标签页管理
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          show_buffer_close_icons = false,
          offsets = {
            { filetype = "NvimTree", text = "Explorer" },
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      })

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
      keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)
      keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Close buffer (pick)" })

      -- 缓冲区管理
      keymap("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
    end,
  },
}
