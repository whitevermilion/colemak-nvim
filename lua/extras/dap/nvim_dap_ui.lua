-- nvim/lua/extras/dap/nvim_dap_ui.lua
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup({
      controls = {
        enabled = false, -- 禁用控制栏，保持界面简洁
      },
      layouts = {
        {
          elements = {
            { id = "stacks", size = 0.2 }, -- 调用栈
            { id = "scopes", size = 0.5 }, -- 作用域
            { id = "breakpoints", size = 0.15 }, -- 断点
            { id = "watches", size = 0.15 }, -- 监视
          },
          position = "left",
          size = 0.2, -- 20% 宽度
        },
        {
          elements = {
            { id = "repl", size = 0.3 }, -- REPL
            { id = "console", size = 0.7 }, -- 控制台
          },
          position = "bottom",
          size = 0.2, -- 20% 高度
        },
      },
    })

    -- 自动打开/关闭调试界面
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end

    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Dap UI" })
    vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Evaluate expression" })
  end,
}
