-- ~/.config/nvim/lua/core/autocmds.lua
local M = {}

function M.setup()
	local augroup = function(name)
		return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
	end

	-- 1. 文件变更检测
	vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave" }, {
		group = augroup("checktime"),
		callback = vim.cmd.checktime,
	})

	-- 2. 复制高亮
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup("highlight_yank"),
		callback = function()
			vim.highlight.on_yank({ timeout = 250 })
		end,
	})

	-- 3. 窗口自适应
	vim.api.nvim_create_autocmd("VimResized", {
		group = augroup("resize_splits"),
		callback = function()
			vim.defer_fn(vim.cmd.wincmd_eq, 50)
		end,
	})

	-- 4. 光标记忆
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = augroup("last_loc"),
		callback = function(event)
			local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
			if mark[1] > 0 then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})

	-- 5. 文本文件设置
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("wrap_spell"),
		pattern = { "text", "markdown", "gitcommit" },
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})

	-- 6. 自动创建目录
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup("auto_create_dir"),
		callback = function(event)
			local dir = vim.fs.dirname(event.file)
			if dir ~= "" and not vim.uv.fs_stat(dir) then
				vim.fn.mkdir(dir, "p")
			end
		end,
	})
end

return M
