-- 放在：~/.config/nvim/lua/extras/ai/copilot.lua

return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
      },
      panel = {
        enabled = true,
      },
    },
    config = function(_, opts)
      -- 1) 基本初始化
      require("copilot").setup(opts)

      -- 2) 快捷键映射（安全方式：使用 pcall 来防止未加载模块时报错）
      local map = vim.keymap.set

      -- Insert 模式：按 <C-J> 接受当前 inline 建议（如果有），否则不做任何事
      -- 说明：这里不会 fallback 到插入字符，避免与其他补全/键位冲突；你可以按需改为带 fallback 的行为
      map("i", "<C-J>", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if not ok then return end
        if suggestion.is_visible() then suggestion.accept() end
      end, { silent = true, desc = "Copilot: accept suggestion (if visible)" })

      -- Insert 模式：按 <M-j> (Alt+j) 切到下一个建议（如果有）
      map("i", "<M-j>", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if not ok then return end
        if suggestion.is_visible() then suggestion.next() end
      end, { silent = true, desc = "Copilot: next suggestion" })

      -- Insert 模式：按 <M-k> (Alt+k) 切到上一个建议（如果有）
      map("i", "<M-k>", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if not ok then return end
        if suggestion.is_visible() then suggestion.prev() end
      end, { silent = true, desc = "Copilot: prev suggestion" })

      -- Insert 模式：按 <C-]> 拒绝/关闭当前 inline 建议（如果有）
      map("i", "<C-]>", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if not ok then return end
        if suggestion.is_visible() then suggestion.dismiss() end
      end, { silent = true, desc = "Copilot: dismiss suggestion" })

      -- Normal 模式：打开 Copilot 面板（查看历史建议/选择多条建议）
      map("n", "<leader>cp", function()
        local ok, panel = pcall(require, "copilot.panel")
        if not ok then
          vim.notify("copilot.panel not available", vim.log.levels.WARN)
          return
        end
        panel.open()
      end, { noremap = true, silent = true, desc = "Copilot: open panel" })

      -- Panel 模式下的常用快捷键（如果 panel 打开，按下列键来导航/接受/关闭）
      -- 这里我们在全局注册 normal-mode 映射作为便捷键；panel 内部可能也会绑定特定键
      map("n", "<leader>cn", function()
        local ok, panel = pcall(require, "copilot.panel")
        if not ok then return end
        panel.next()
      end, { noremap = true, silent = true, desc = "Copilot panel: next item" })

      map("n", "<leader>cpv", function()
        local ok, panel = pcall(require, "copilot.panel")
        if not ok then return end
        panel.prev()
      end, { noremap = true, silent = true, desc = "Copilot panel: prev item" })

      map("n", "<leader>ca", function()
        local ok, panel = pcall(require, "copilot.panel")
        if not ok then return end
        panel.accept()
      end, { noremap = true, silent = true, desc = "Copilot panel: accept selected" })

      map("n", "<leader>cd", function()
        local ok, panel = pcall(require, "copilot.panel")
        if not ok then return end
        panel.close()
      end, { noremap = true, silent = true, desc = "Copilot panel: close" })

      -- 3) 可选：在命令行定义几个便捷命令（更易记）
      vim.api.nvim_create_user_command("CopilotAccept", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if ok and suggestion.is_visible() then suggestion.accept() end
      end, { desc = "Accept Copilot inline suggestion" })

      vim.api.nvim_create_user_command("CopilotNext", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if ok and suggestion.is_visible() then suggestion.next() end
      end, { desc = "Next Copilot inline suggestion" })

      vim.api.nvim_create_user_command("CopilotPrev", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if ok and suggestion.is_visible() then suggestion.prev() end
      end, { desc = "Prev Copilot inline suggestion" })

      vim.api.nvim_create_user_command("CopilotDismiss", function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if ok and suggestion.is_visible() then suggestion.dismiss() end
      end, { desc = "Dismiss Copilot inline suggestion" })

      -- 4) 使用说明（提示给用户）
      vim.notify(
        "copilot.lua: keymaps loaded (i:<C-J> accept, i:<M-j>/<M-k> next/prev, n:<leader>cp panel)",
        vim.log.levels.INFO
      )
    end,
  },

  -- copilot-cmp：把 copilot 作为 nvim-cmp 的 source（如果你用 nvim-cmp，强烈建议）
  {
    "zbirenbaum/copilot-cmp",
    after = "copilot.lua",
    config = function()
      -- 通常不需要特殊配置，安装后会注册 source
      -- 你可以在 nvim-cmp 的 sources 中把 { name = "copilot" } 放到合适位置以控制优先级
      local ok, copilot_cmp = pcall(require, "copilot_cmp")
      if ok then copilot_cmp.setup() end
    end,
  },
}
