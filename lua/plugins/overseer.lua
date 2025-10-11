-- overseer_minimal.lua
return {
  'stevearc/overseer.nvim',
  cmd = { "OverseerRun", "OverseerToggle", "OverseerRestart" },
  keys = {
    { "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "Toggle Overseer" },
    { "<leader>or", "<cmd>OverseerRun<CR>", desc = "Run task" },
  },
  
  opts = {
    strategy = "toggleterm",
    task_list = { 
      direction = "bottom",
      -- 添加快捷键绑定
      bindings = {
        ["<CR>"] = "RunAction",
        ["r"] = "Restart",
        ["d"] = "Delete", 
        ["q"] = "Close",
        ["j"] = "IncreaseDetail",
        ["k"] = "DecreaseDetail",
      }
    },
    form = { border = "rounded" },
    log = { level = "error" },
    history = { max_items = 20 },
  },
  
  config = function(_, opts)
    require("overseer").setup(opts)
  end,
}
