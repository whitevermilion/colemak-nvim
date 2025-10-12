return {
  "theHamsta/nvim-dap-virtual-text",
  event = "User DapStarted",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = true,
    })
  end,
}
