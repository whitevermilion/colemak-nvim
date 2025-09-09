return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() 
      local config = require("dap").get_active_config()
      config = require("dap.utils").ensure_config(config)
      config = require("dap").configurations[config.type][config._index]
      require("dap").run(require("dap.utils").table_merge(config, {
        args = vim.fn.split(vim.fn.input("Arguments: ", table.concat(config.args or {}, " ")))
      }))
    end, desc = "Run with Args" 
    },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
  
  config = function()
    local dap = require("dap")

    -- 配置 codelldb 适配器
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = "/home/red/.local/share/nvim/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- 配置 C++ 调试配置
    dap.configurations.cpp = {
      {
        name = "Launch C++",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp
    
    -- 调试图标
	vim.fn.sign_define('DapBreakpoint', {
		text = '●', -- 实心圆
		texthl = 'DiagnosticError',
		linehl = '',
		numhl = ''
	})

	vim.fn.sign_define('DapBreakpointCondition', {
		text = '◆', -- 菱形
		texthl = 'DiagnosticInfo',
		linehl = '',
		numhl = ''
	})

	vim.fn.sign_define('DapLogPoint', {
		text = '◇', -- 空心菱形
		texthl = 'DiagnosticHint',
		linehl = '',
		numhl = ''
	})

	vim.fn.sign_define('DapStopped', {
		text = '→', -- 右箭头
		texthl = 'DiagnosticWarn',
		linehl = 'DapStoppedLine',
		numhl = ''
	})
    -- 高亮设置
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#3e4452" })
  end,
}
