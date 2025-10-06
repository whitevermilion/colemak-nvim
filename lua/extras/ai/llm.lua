return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  
  opts = {
    url = "https://api.deepseek.com/chat/completions",
    model = "deepseek-chat",
    api_type = "openai",
    fetch_key = function() return vim.env.DEEPSEEK_API end,
  },
  
  keys = {
    { "<leader>ac", "<cmd>LLMSessionToggle<cr>", desc = "AI Chat" },
    { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler Explain this code<cr>", desc = "Explain" },
    { "<leader>at", mode = "v", "<cmd>LLMSelectedTextHandler Translate to Chinese<cr>", desc = "Translate" },
  },
  
  config = function(_, opts)
    require("llm").setup(opts)
  end,
}
