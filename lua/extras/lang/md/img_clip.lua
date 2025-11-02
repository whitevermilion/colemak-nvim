return {
  -- 插件名称
  "HakonHarnes/img-clip.nvim",
  -- 只在特定文件类型中加载插件（减少内存占用）
  ft = { "tex", "markdown", "typst" },

  -- 插件配置选项
  opts = {
    -- 默认配置（所有文件类型通用）
    default = {
      -- 图片保存目录（相对于当前文件）
      dir_path = "./attachments",
      -- 是否使用绝对路径（false = 使用相对路径）
      use_absolute_path = false,
      -- 是否将图片复制到指定目录（true = 复制，false = 移动）
      copy_images = true,
      -- 是否提示输入文件名（false = 自动生成文件名）
      prompt_for_file_name = false,
      -- 自动生成文件名的格式（年月日-时分秒）
      file_name = "%y%m%d-%H%M%S",
      -- 默认图片格式（avif格式，体积小质量高）
      extension = "avif",
      -- 图片处理命令（使用ImageMagick转换图片质量）
      process_cmd = "magick convert - -quality 75 avif:-",
    },

    -- 针对不同文件类型的特定配置
    filetypes = {
      -- Markdown 文件配置
      markdown = {
        -- 插入图片的模板语法
        template = "![image$CURSOR]($FILE_PATH)",
      },

      -- LaTeX 文件配置
      tex = {
        -- LaTeX 专用的图片保存目录
        dir_path = "./figs",
        -- LaTeX 常用的图片格式
        extension = "png",
        -- 不进行图片处理（保持原样）
        process_cmd = "",
        -- LaTeX 图片插入模板
        template = [[
    \begin{figure}[h]
      \centering
      \includegraphics[width=0.8\textwidth]{$FILE_PATH}
    \end{figure}
        ]], ---@type string | fun(context: table): string
      },

      -- Typst 文件配置
      typst = {
        -- Typst 专用的图片保存目录
        dir_path = "./figs",
        -- Typst 常用的图片格式
        extension = "png",
        -- 提高图片DPI质量
        process_cmd = "magick convert - -density 300 png:-",
        -- Typst 图片插入模板
        template = [[
          #align(center)[#image("$FILE_PATH", height: 80%)]
          ]],
      },
    },
  },

  -- 键盘快捷键配置
  keys = {
    -- 按下 <leader>P 执行 PasteImage 命令
    { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
