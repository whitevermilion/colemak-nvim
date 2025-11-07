-- nvim/lua/passiveplugins/dashboard.lua
return
-- dashboard-nvim - 启动界面
{
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "akinsho/toggleterm.nvim",
    "nvim-tree/nvim-tree.lua",
  },
  config = function()
    local dashboard = require("dashboard")
    local logo = [[
	██████╗ ██╗      █████╗  ██████╗██╗  ██╗         
	██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝         
	██████╔╝██║     ███████║██║     █████╔╝█████╗    
	██╔══██╗██║     ██╔══██║██║     ██╔═██╗╚════╝    
	██████╔╝███████╗██║  ██║╚██████╗██║  ██╗         
	╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝         
                                                 
	██╗   ██╗ ██████╗ ██╗ ██████╗███████╗    ██╗     
	██║   ██║██╔═══██╗╚═╝██╔════╝██╔════╝    ██║     
	██║   ██║██║   ██║██║██║     █████╗      ██║     
	╚██╗ ██╔╝██║   ██║██║██║     ██╔══╝      ╚═╝     
	 ╚████╔╝ ╚██████╔╝██║╚██████╗███████╗    ██╗     
	  ╚═══╝   ╚═════╝ ╚═╝ ╚═════╝╚══════╝    ╚═╝     
      ]]
    logo = string.rep("\n", 3) .. logo .. "\n\n"

    dashboard.setup({
      theme = "doom",
      hide = { statusline = false },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            icon = " ",
            desc = " Find File              ",
            action = function()
              require("telescope.builtin").oldfiles({
                mappings = {
                  i = { ["<CR>"] = require("telescope.actions").select_default },
                  n = { ["<CR>"] = require("telescope.actions").select_default },
                },
              })
            end,
            key = "f",
          },
          {
            icon = " ",
            desc = " Recent Files          ",
            action = function()
              require("telescope.builtin").oldfiles()
            end,
            key = "r",
          },
          {
            icon = " ",
            desc = " Config                 ",
            action = function()
              require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath("config"),
              })
            end,
            key = "c",
          },
          {
            icon = " ",
            desc = " Extras Manager                  ",
            action = function()
              vim.cmd("edit ~/.config/nvim/lua/core/lazy.lua")
            end,
            key = "o",
          },
          {
            icon = " ",
            desc = " Open Terminal         ",
            action = "ToggleTerm",
            key = "t",
          },
          {
            icon = " ",
            desc = " Quit Neovim           ",
            action = "q!",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = string.format("%.2f", stats.startuptime)
          return {
            "",
            "",
            "",
            "",
            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    })

    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#89b4fa", bold = true })
    vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#cba6f7" })
    vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#a6e3a1", italic = true })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 then
          vim.cmd("Dashboard")
        end
      end,
    })
  end,
}
