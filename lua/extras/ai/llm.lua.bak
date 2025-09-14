return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  config = function()
    -- 安全地从环境变量中读取 API 密钥（推荐做法）
    local api_key = os.getenv("DEEPSEEK_API_KEY")
    
    -- 如果没有设置环境变量，显示警告
    if not api_key or api_key == "" then
      -- 使用 print 而不是 vim.notify，避免与 nvim-notify 冲突
      print("警告: 请设置 DEEPSEEK_API_KEY 环境变量")
      -- 或者延迟显示通知
      vim.schedule(function()
        vim.notify("请设置 DEEPSEEK_API_KEY 环境变量", vim.log.levels.ERROR)
      end)
      return
    end

    require("llm").setup({
      url = "https://api.deepseek.com/v1/chat/completions",
      model = "deepseek-chat",
      api_key = api_key,
      api_type = "openai",
      request_timeout = 30000,
      additional_params = {
        temperature = 0.7,
        max_tokens = 2048,
      }
    })
  end,
  keys = {
    { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "LLM: 打开/关闭聊天" },
    { "<leader>aa", mode = "v", "<cmd>LLMSelectedTextHandler<cr>", desc = "LLM: 处理选中文本" },
    { "<leader>ap", mode = "n", "<cmd>LLMAppHandler<cr>", desc = "LLM: 应用处理器" },
  },
}
