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
        enabled = true,
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
            { id = "repl", size = 1.0 },
          },
          position = "bottom",
          size = 8,
        },
      },
    })

    -- 自动打开/关闭调试界面（重要！）
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
