-- ~/.config/nvim/lua/plugins/aerial.lua
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>so", "<cmd>AerialToggle!<CR>", desc = "[Aerial] 切换符号大纲" },
  },
  opts = {
    -- 布局设置
    layout = {
      min_width = 20,
      default_direction = "prefer_right",
    },

    -- 显示设置
    show_guides = true,
    link_tree_to_folds = true,

    -- 后端设置（LSP + Treesitter 足够）
    backends = { "lsp", "treesitter" },

    -- 过滤选项（保留常用符号类型）
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Method",
      "Struct",
    },

    -- 图标设置（使用默认）
    nerd_font = "auto",

    -- 高亮设置
    highlight_on_hover = true,
  },
  config = function(_, opts)
    require("aerial").setup(opts)

    -- 自动附加到 LSP（简化版）
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then require("aerial").on_attach(client, args.buf) end
      end,
    })
  end,
}
