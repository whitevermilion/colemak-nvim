-- ~/.config/nvim/lua/lang/lua_develop.lua
return {
  -- Lua 语言服务器
  {
    "neovim/nvim-lspconfig",
    ft = "lua",
    config = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false
            },
            telemetry = { enable = false }
          }
        }
      })
    end
  },
  
  -- 基本调试支持
  {
    "mfussenegger/nvim-dap",
    ft = "lua",
    dependencies = {
      "jbyuki/one-small-step-for-vimkind", -- Lua 调试适配器
    },
    config = function()
      local dap = require("dap")
      
      -- 简单调试配置
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = "127.0.0.1", port = 8086 })
      end
      
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to Neovim",
        },
        {
          type = "nlua",
          request = "launch",
          name = "Run current file",
          program = function()
            return vim.api.nvim_buf_get_name(0)
          end,
        }
      }
    end
  },
  
  -- 交互式编程环境
  {
    "rafcamlet/nvim-luapad",
    cmd = "Luapad",
    config = function()
      require("luapad").setup({
        -- 基础配置
        split_orientation = "vertical",
        on_init = function()
          -- 设置初始代码
          return [[
            -- Lua 交互式编程环境
            print("Hello, LuaPad!")
            
            -- 尝试输入一些 Lua 代码
            local function greet(name)
              return "Hello, " .. name .. "!"
            end
          ]]
        end
      })
    end
  },
  
  -- 代码片段支持
  {
    "L3MON4D3/LuaSnip",
    ft = "lua",
    dependencies = {
      "rafamadriz/friendly-snippets", -- 提供预定义片段
    },
    config = function()
      require("luasnip").setup()
      
      -- 加载通用 Lua 片段
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
          -- 加载内置 Lua 片段
          vim.fn.stdpath("data") .. "/lazy/friendly-snippets/snippets/lua.json"
        }
      })
      
      -- 添加简单自定义片段
      require("luasnip").add_snippets("lua", {
        require("luasnip").snippet(
          "fun",
          require("luasnip").text_node("function "),
          require("luasnip").insert_node(1, "name"),
          require("luasnip").text_node("("),
          require("luasnip").insert_node(2),
          require("luasnip").text_node(")\n  "),
          require("luasnip").insert_node(3),
          require("luasnip").text_node("\nend")
        ),
        require("luasnip").snippet(
          "for",
          require("luasnip").text_node("for "),
          require("luasnip").insert_node(1, "i"),
          require("luasnip").text_node(" = "),
          require("luasnip").insert_node(2, "1"),
          require("luasnip").text_node(", "),
          require("luasnip").insert_node(3, "10"),
          require("luasnip").text_node(" do\n  "),
          require("luasnip").insert_node(4),
          require("luasnip").text_node("\nend")
        )
      })
    end
  },
  
  -- 简单格式化
  {
    "stevearc/conform.nvim",
    ft = "lua",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" }
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          stylua = {
            condition = function(ctx)
              -- 仅在项目中启用格式化
              return vim.fs.find(".stylua.toml", { path = ctx.filename, upward = true })[1]
            end
          }
        }
      })
    end
  }
}
