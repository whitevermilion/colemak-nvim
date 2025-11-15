-- nvim/lua/extras/dap/nvim_dap.lua

return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "[dap]切换断点",
    },
    {
      "<leader>dB", -- 注意这里是大写 B
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "[dap]设置条件断点",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "[dap]运行/继续",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_over()
      end,
      desc = "[dap]步过函数",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "[dap]步入函数",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "[dap]步出函数",
    },
    {
      "<leader>dw",
      function()
        local expr = vim.fn.input("监视表达式: ")
        if expr ~= "" then
          require("dapui").eval(expr, {})
        end
      end,
      desc = "[dap]添加监视表达式",
    },
    {
      "<leader>dW",
      function()
        require("dapui").float_element("watches", {})
      end,
      desc = "[dap]打开监视窗口",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "[dap]终止调试",
    },
  },

  config = function()
    local dap = require("dap")

    -- 配置 codelldb 适配器
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "/home/red/.local/share/nvim/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- 调试配置
    local configuration = {
      name = "调试程序",
      type = "codelldb",
      request = "launch",
      program = function()
        -- 获取当前文件名（不含扩展名）
        local current_file = vim.fn.expand("%:t:r")
        local default_path = vim.fn.getcwd() .. "/" .. current_file

        return vim.fn.input("程序路径: ", default_path, "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      console = "integratedTerminal",
      args = {},
    }

    dap.configurations.c = { configuration }
    dap.configurations.cpp = { configuration }
    dap.configurations.rust = { configuration }

    -- 核心调试图标
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "DapStoppedLine" })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#3e4452" })
  end,
}
