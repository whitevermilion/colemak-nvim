return {
  "jubnzv/mdeval.nvim", -- 使用正确的插件仓库地址
  ft = { "markdown", "vimwiki", "norg" }, -- 指定支持的文件类型:cite[2]
  opts = {
    -- 指定需要支持的语言及其执行命令
    languages = {
      python = {
        command = "python", -- 解释器命令
        args = { "-c" }, -- 执行 -c 选项后的代码
      },
      lua = {
        command = "lua",
        args = { "-e" }, -- 执行 -e 选项后的代码
      },
      bash = {
        command = "bash",
        args = { "-c" },
      },
      javascript = {
        command = "node",
        args = { "-e" },
      },
      -- 你可以根据需要添加更多语言，如 cpp, rust, haskell 等
    },
    require_confirmation = false,
  },
  config = function(_, opts)
    require('mdeval').setup(opts)
  end,
}
