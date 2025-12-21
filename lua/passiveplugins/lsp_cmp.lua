-- ~/.config/nvim/lua/passiveplugins/lsp_cmp.lua
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      -- 精简图标映射 - 只保留最常用的
      local kind_icons = {
        Text = "", -- 文本、注释、字符串
        Method = "󰆧", -- 方法
        Function = "󰊕", -- 函数
        Variable = "󰂡", -- 变量
        Constant = "󰏿", -- 常量、宏定义
        Keyword = "󰌋", -- 关键字
        Struct = "", -- 结构体、类
        File = "󰈙", -- 文件
        Folder = "󰉋", -- 文件夹
        Default = "?",
      }

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-e>"] = cmp.mapping.select_prev_item(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or kind_icons.Default, vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").config.setup({
        history = true,
      })
    end,
  },
}
