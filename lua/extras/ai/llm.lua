-- nvim/lua/extras/ai/llm.lua
return {
	"Kurama622/llm.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
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
        5. 使用中文回答，但为了保持代码和术语的准确性,部分专业词汇可以使用英文
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
		-- 添加 spinner 动画
		spinner = {
			text = {
				"󰧞󰧞",
				"󰧞󰧞",
				"󰧞󰧞",
				"󰧞󰧞",
			},
			hl = "Title",
		},

		-- 添加弹窗配置
		popwin_opts = {
			relative = "cursor",
			enter = true,
			focusable = true,
			zindex = 50,
			position = { row = -7, col = 15 },
			size = { height = 15, width = "50%" },
			border = {
				style = "single",
				text = { top = " AI助手 ", top_align = "center" },
			},
		},
		-- 启用会话保存以使用历史记录功能
		save_session = true,
		max_history = 15,
	},

	keys = {
		{ "<leader>ac", "<cmd>LLMSessionToggle<cr>", desc = "[LLM] AI聊天" },
		{ "<leader>at", mode = "v", "<cmd>LLMAppHandler Translate<cr>", desc = "[LLM]翻译" },
		{ "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>", desc = "[LLM]解释代码" },
		{ "<leader>ao", mode = "v", "<cmd>LLMAppHandler OptimizeCode<cr>", desc = "[LLM]优化代码" },
		{ "<leader>ad", mode = "v", "<cmd>LLMAppHandler DocString<cr>", desc = "[LLM] 生成文档" },
	},

	config = function(_, opts)
		local tools = require("llm.tools")

		opts.app_handler = {
			CodeExplain = {
				handler = tools.flexi_handler,
				prompt = "解释以下代码，请只返回解释内容，用中文回答",
				opts = {
					enter_flexible_window = true,
				},
			},

			Translate = {
				handler = tools.qa_handler,
				prompt = "将以下内容翻译成中文",
				opts = {
					component_width = "60%",
					query = {
						title = " 󰊿 翻译 ",
					},
				},
			},

			OptimizeCode = {
				handler = tools.side_by_side_handler,
				opts = {
					right = {
						title = " 优化版本 ",
					},
				},
			},

			DocString = {
				handler = tools.action_handler,
				prompt = [[你是一个AI编程助手。需要为给定语言编写高质量的文档字符串，遵循最佳实践。
                核心任务包括：
                - 参数和返回类型（如果适用）
                - 可能抛出或返回的错误（根据语言）

                要求：
                - 将生成的文档字符串放在代码开始之前
                - 仔细遵循示例格式（如果提供）
                - 在答案中使用Markdown格式
                - 在Markdown代码块开头包含编程语言名称]],
				opts = {
					only_display_diff = true,
				},
			},
		}

		require("llm").setup(opts)
	end,
}
