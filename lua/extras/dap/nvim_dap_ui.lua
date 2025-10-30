-- nvim/lua/extras/dap/nvim_dap_ui.lua
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local map = vim.keymap.set

    dapui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "↓",
          step_over = "→",
          step_out = "↑",
          step_back = "←",
          terminate = "⏹",
        },
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.7 },
            { id = "breakpoints", size = 0.1 },
            { id = "stacks", size = 0.1 },
            { id = "watches", size = 0.1 },
          },
          position = "left",
          size = 25,
        },
        {
          elements = {
            { id = "repl", size = 1.0 }, -- REPL 独占底部区域
          },
          position = "bottom",
          size = 8,
        },
      },
    })

    -- 安全的监听器注册
    dap.listeners.after.event_initialized["dapui_config_open"] = function()
      dapui.open({ reset = true })
    end

    dap.listeners.before.event_terminated["dapui_config_close"] = function()
      dapui.close({})
    end

    dap.listeners.before.event_exited["dapui_config_close"] = function()
      dapui.close({})
    end

    -- 处理异常中断
    vim.api.nvim_create_autocmd("User", {
      pattern = "DAPStopped",
      callback = function()
        if dap.session() == nil then
          dapui.close({})
        end
      end,
    })

    -- 添加 UI 键位
    map("n", "<leader>du", dapui.toggle, { desc = "Toggle Dap UI" })
    map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Evaluate expression" })

    -- 增强的浮动窗口处理
    map("n", "<leader>df", function()
      if dapui.floating() then
        dapui.close({})
      else
        local success, _ = pcall(dapui.float_element, "scopes", { enter = true })
        if not success then
          vim.notify("No scopes available", vim.log.levels.WARN)
        end
      end
    end, { desc = "Toggle Float Scopes" })
  end,
}
