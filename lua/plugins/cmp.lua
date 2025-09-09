-- lua/plugins/completion.lua
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
      
      -- 加载通用代码片段库
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- 图标类型映射
      local kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          -- 使用 Tab 键采纳补全建议
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })  -- 选择当前高亮项
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()       -- 片段跳转
            else
              fallback()                    -- 默认 Tab 行为
            end
          end, { "i", "s" }),
          
          -- 片段内反向跳转
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          
          -- 仅保留必要导航键
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          
          -- 基础功能键
          ["<C-Space>"] = cmp.mapping.complete(), -- 触发补全
          ["<C-e>"] = cmp.mapping.abort(),        -- 关闭补全
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },    -- LSP 源
          { name = "luasnip" },      -- 片段源
          { name = "buffer" },       -- 缓冲区内容
          { name = "path" },         -- 文件路径
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- 添加图标
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "?", vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
          }),
        },
        experimental = {
          ghost_text = true,  -- 显示半透明预览文本
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local luasnip = require("luasnip")
      
      -- 片段历史保留
      luasnip.config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        region_check_events = "InsertEnter",
        delete_check_events = "InsertLeave",
      })
    end,
  },
}
