return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  
  opts = {
    url = "https://api.deepseek.com/chat/completions",
    model = "deepseek-chat",
    api_type = "openai",
    fetch_key = function() return vim.env.DEEPSEEK_API end,
    
    -- 添加你的定制化 prompt
    prompt = "You are a senior code engineer proficient in C++ and C. You enjoy programming with Linux and Neovim, and strive to write elegant code.",
    
    -- 优化对话参数
    temperature = 0.3,      -- 较低温度，代码回答更稳定
    top_p = 0.7,            -- 适中的多样性
    max_tokens = 4096,      -- 足够的回复长度
    
    -- 界面优化
    prefix = {
      user = { text = "  ", hl = "Title" },
      assistant = { text = "  ", hl = "Added" },  -- 使用程序员图标
    },

    -- 添加会话内快捷键配置
    keys = {
      -- 输入窗口快捷键
      ["Input:Submit"] = { mode = "n", key = "<CR>" },  -- 发送消息
      ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },  -- 取消
      ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },  -- 重新发送
      
      -- 历史记录导航（需要 save_session = true）
      ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-n>" },
      ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-e>" },
      
      -- 输出窗口快捷键
      ["Output:Ask"] = { mode = "n", key = "i" },  -- 继续提问
      ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
      ["Output:Resend"] = { mode = "n", key = "<C-r>" },
      
      -- 会话控制
      ["Session:Close"] = { mode = "n", key = { "<Esc>", "Q" } },
      
      -- 滚动控制
      ["PageUp"] = { mode = { "i", "n" }, key = "<C-b>" },
      ["PageDown"] = { mode = { "i", "n" }, key = "<C-f>" },
      ["HalfPageUp"] = { mode = { "i", "n" }, key = "<C-u>" },
      ["HalfPageDown"] = { mode = { "i", "n" }, key = "<C-d>" },
      ["JumpToTop"] = { mode = "n", key = "gg" },
      ["JumpToBottom"] = { mode = "n", key = "G" },
    },
    
    -- 启用会话保存以使用历史记录功能
    save_session = true,
    max_history = 15,
  },
  
  keys = {
    { "<leader>ac", "<cmd>LLMSessionToggle<cr>", desc = "AI Chat" },
    { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler Explain this code<cr>", desc = "Explain" },
    { "<leader>at", mode = "v", "<cmd>LLMSelectedTextHandler Translate to Chinese<cr>", desc = "Translate" },
    { "<leader>ac", mode = "v", "<cmd>LLMSelectedTextHandler Optimize this C++ code<cr>", desc = "Optimize C++" },
    { "<leader>al", mode = "v", "<cmd>LLMSelectedTextHandler Review this Linux code<cr>", desc = "Review Linux Code" },
  },
  
  config = function(_, opts)
    require("llm").setup(opts)
  end,
}
