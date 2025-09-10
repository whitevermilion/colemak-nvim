return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "查找文件" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "全局内容搜索" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "缓冲区切换" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "帮助文档查找" },
  },
  opts = {
    defaults = {
      prompt_prefix = "🔍 ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { "node_modules", ".git/" },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-q>"] = function()
            require("telescope.actions").send_to_qflist()
            require("telescope.actions").preview()
          end,
        },
        n = {
          ["q"] = "close",
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
      },
    },
    extensions = {
      -- 扩展配置
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    
    -- 修复复合操作支持
    local actions = require("telescope.actions")
    actions._increment_custom = function()
      -- 避免复合操作错误
    end
  end,
}
