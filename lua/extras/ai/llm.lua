-- nvim/lua/extras/ai/llm.lua
return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },

  opts = {
    url = "https://api.deepseek.com/chat/completions",
    model = "deepseek-chat",
    api_type = "openai",
    fetch_key = function()
      return vim.env.DEEPSEEK_API
    end,

    prompt = [[
你是一位资深的 C++ 和 C 语言代码工程师。你熟悉 Linux 开发和 Neovim 使用，擅长编写高效、可维护的代码。
请遵循以下原则：
1. 提供具体、可执行的代码建议
2. 解释代码的工作原理和设计思路
3. 考虑代码的性能和可读性
4. 对于问题，给出多种解决方案并分析优缺点
5. 使用中文回答，但保持代码和术语的准确性
    ]],

    -- 优化对话参数
    temperature = 0.2, -- 较低温度，代码回答更稳定
    top_p = 0.8, -- 较高的多样性
    max_tokens = 4096, -- 足够的回复长度

    -- 界面优化
    prefix = {
      user = { text = "  ", hl = "Title" },
      assistant = { text = "  ", hl = "Added" }, -- 使用程序员图标
    },

    -- 添加会话内快捷键配置
    keys = {
      -- 输入窗口快捷键
      ["Input:Submit"] = { mode = "n", key = "<CR>" }, -- 发送消息
      ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" }, -- 取消
      ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" }, -- 重新发送

      -- 历史记录导航（需要 save_session = true）
      ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
      ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },
      -- 输出窗口快捷键
      ["Output:Ask"] = { mode = "n", key = "i" }, -- 继续提问
      -- 会话控制
      ["Session:Close"] = { mode = "n", key = { "<Esc>", "Q" } },
      -- 滚动控制
      ["HalfPageUp"] = { mode = { "i", "n" }, key = "<C-e>" },
      ["HalfPageDown"] = { mode = { "i", "n" }, key = "<C-n>" },
      ["JumpToTop"] = { mode = "n", key = "gg" },
      ["JumpToBottom"] = { mode = "n", key = "G" },
    },

    -- 启用会话保存以使用历史记录功能
    save_session = true,
    max_history = 15,
  },

  keys = {
    { "<leader>ac", "<cmd>LLMSessionToggle<cr>", desc = "AI Chat" },
    { "<leader>at", mode = "v", "<cmd>LLMSelectedTextHandler Translate to Chinese<cr>", desc = "Translate" },
    { "<leader>aq", mode = "v", "<cmd>LLMSelectedTextHandler<cr>", desc = "Ask about selected code" },
  },

  config = function(_, opts)
    require("llm").setup(opts)
  end,
}
