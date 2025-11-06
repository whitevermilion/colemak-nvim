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
        enabled = false,
      },
      -- 简化各个元素的显示
      elements = {
        stacks = {
          -- 简化调用栈显示
          render = function(element)
            -- 过滤掉标准库和系统调用
            local frames = element.frames or {}
            local filtered_frames = {}

            for _, frame in ipairs(frames) do
              local source_name = frame.source and frame.source.name or ""
              -- 保留用户代码和主要文件，过滤标准库
              if
                not string.match(source_name, "lib.*%.so")
                and not string.match(source_name, "std::")
                and not string.match(source_name, "typeinfo")
                and not string.match(source_name, "libc%+%+")
              then
                table.insert(filtered_frames, frame)
              end
            end

            -- 使用过滤后的帧
            element.frames = filtered_frames
            return require("dapui.elements.stacks").render(element)
          end,
        },
        scopes = {
          -- 简化作用域显示
          auto_expand = false, -- 不自动展开所有作用域
          max_name_length = 30, -- 限制变量名显示长度
          max_value_length = 50, -- 限制变量值显示长度
          render = function(element)
            -- 过滤掉标准库类型的变量
            local scopes = element.scopes or {}
            for _, scope in ipairs(scopes) do
              local variables = scope.variables or {}
              local filtered_vars = {}

              for _, variable in ipairs(variables) do
                local var_type = variable.type or ""
                local var_name = variable.name or ""
                -- 保留基本类型和用户定义类型，过滤复杂标准库类型
                if
                  not string.match(var_type, "std::.*allocator")
                  and not string.match(var_type, "std::.*basic_string")
                  and not string.match(var_name, "^__")
                then -- 过滤编译器生成的变量
                  -- 简化显示值
                  if variable.value and string.len(variable.value) > 50 then
                    variable.value = string.sub(variable.value, 1, 47) .. "..."
                  end
                  table.insert(filtered_vars, variable)
                end
              end

              scope.variables = filtered_vars
            end

            return require("dapui.elements.scopes").render(element)
          end,
        },
        breakpoints = {
          -- 断点列表通常已经很简洁
        },
        watches = {
          -- 监视表达式由用户控制，不需要简化
        },
        repl = {
          -- 保留 REPL 完整功能
        },
        console = {
          -- 保留控制台完整输出
        },
      },
      layouts = {
        {
          elements = {
            { id = "stacks", size = 0.2 },
            { id = "scopes", size = 0.5 },
            { id = "breakpoints", size = 0.15 },
            { id = "watches", size = 0.15 },
          },
          position = "left",
          size = 0.2,
        },
        {
          elements = {
            { id = "repl", size = 0.3 },
            { id = "console", size = 0.7 },
          },
          position = "bottom",
          size = 0.2,
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
