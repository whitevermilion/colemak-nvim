return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" }, -- 按需加载，优化启动速度
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    -- 这里可以放置全局LSP设置，或留空
    -- 你的具体服务器配置将在 lsp/ 目录下独立加载
  end,
}
