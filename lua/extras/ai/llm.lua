return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  config = function()
    -- 安全地从环境变量中读取 API 密钥（推荐做法）
    local api_key = os.getenv("MOONSHOT_API_KEY")
    
    -- 如果没有设置环境变量，可以直接在这里指定密钥（不推荐，除非临时测试）
    if not api_key or api_key == "" then
      api_key = "sk-2zDZYczwbQHDTtfoPtcHxDAhce4wFAqDLzaPq0NQxNAW82vo"
      vim.notify("使用硬编码的 Moonshot API 密钥，建议设置 MOONSHOT_API_KEY 环境变量", vim.log.levels.WARN)
    end

    require("llm").setup({
      -- 使用 Moonshot 的 API 端点
      url = "https://api.moonshot.cn/v1/chat/completions",
      -- 选择 Moonshot 提供的模型
      model = "moonshot-v1-8k", -- 也可以是 moonshot-v1-32k 或 moonshot-v1-128k
      api_key = api_key,
      api_type = "openai", -- 保持与OpenAI兼容的API类型
      -- 可选：设置请求超时时间（毫秒）
      request_timeout = 30000, -- 30 秒
      -- 可选：设置默认的初始化提示词
      initial_prompt = "你是一个专业的编程助手，精通多种编程语言和开发工具。请用简洁准确的语言回答。"
    })
  end,
  keys = {
    { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "LLM: 打开/关闭聊天" },
    { "<leader>aa", mode = "v", "<cmd>LLMSelectedTextHandler<cr>", desc = "LLM: 处理选中文本" },
    { "<leader>ap", mode = "n", "<cmd>LLMAppHandler<cr>", desc = "LLM: 应用处理器" },
  },
}
