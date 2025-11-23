Startuptime: 115.25ms

Based on the actual CPU time of the Neovim process till UIEnter.
This is more accurate than `nvim --startuptime`.
LazyStart 9.85ms
LazyDone 41.26ms (+31.4ms)
UIEnter 115.25ms (+73.99ms)

Profile

You can press <C-s> to change sorting between chronological order & time taken.
Press <C-f> to filter profiling entries that took more time than a given threshold

    ●  lazy.nvim 5.52ms
      ➜  module 0.57ms
      ➜  config 0.4ms
      ➜  spec 3.16ms
        ★  pkg 0.03ms
        ★  plugins.bufferline 0.06ms
        ★  plugins.code_runner 0.04ms
        ★  plugins.editor 0.02ms
        ★  plugins.git 0.03ms
        ★  plugins.lazygit 0.09ms
        ★  plugins.mermaid 0.02ms
        ★  plugins.nvim_tree 0.07ms
        ★  plugins.nvim_treesitter 0.02ms
        ★  plugins.overseer 0.02ms
        ★  plugins.telescope 0.02ms
        ★  plugins.toggleterm 0.07ms
        ★  plugins.ufo 0.04ms
        ★  passiveplugins.catppuccin 0.04ms
        ★  passiveplugins.dashboard 0.13ms
        ★  passiveplugins.fcitx 0.02ms
        ★  passiveplugins.icons 0.07ms
        ★  passiveplugins.image 0.02ms
        ★  passiveplugins.lazydev 0.03ms
        ★  passiveplugins.lsp_cmp 0.05ms
        ★  passiveplugins.lsp_conform 0.02ms
        ★  passiveplugins.lsp_linting 0.04ms
        ★  passiveplugins.mason 0.03ms
        ★  passiveplugins.mini-pairs 0.02ms
        ★  passiveplugins.nvim_lastplace 0.02ms
        ★  passiveplugins.rainbow-delimiters 0.05ms
        ★  passiveplugins.scrollbar 0.03ms
        ★  passiveplugins.ui 0.04ms
        ★  passiveplugins.which_key 0.02ms
        ★  extras/extras_list 1.08ms
          ‒  extras/dap.nvim_dap 0.05ms
          ‒  extras/dap.nvim_dap_ui 0.05ms
          ‒  extras/dap.nvim_dap_virtual_text 0.11ms
          ‒  extras/lang/md.img_clip 0.02ms
          ‒  extras/lang/md.markdown_toc 0.02ms
          ‒  extras/lang/md.mdeval 0.02ms
          ‒  extras/lang/md.obsidian 0.05ms
          ‒  extras/lang/md.render_markdown 0.1ms
          ‒  extras/ai.llm 0.24ms
          ‒  extras/leetcode.leetcode 0.27ms
        ★  resolve plugins 0.25ms
      ➜  state 0.13ms
      ➜  install 0.02ms
      ➜  handlers 1.12ms
        ★  mermaid.vim/ftdetect/mermaid.vim 0.03ms
    ●  startup 26.31ms
      ➜  runtime/filetype.lua 0.09ms
      ➜  init 0.02ms
        ★  init  fcitx.vim 0.01ms
      ➜  start 24.73ms
        ★  start  catppuccin 1.47ms
        ★  start  code_runner.nvim 0.82ms
        ★  start  nvim-dap-ui 3.2ms
          ‒  nvim-dap 1.04ms
            ●  nvim-dap-virtual-text 0.74ms
            ●  nvim-dap/plugin/dap.lua 0.07ms
          ‒  nvim-nio 0.04ms
        ★  start  nvim-scrollbar 4.72ms
          ‒  nvim-hlslens 0.15ms
            ●  nvim-hlslens/plugin/hlslens.vim 0.05ms
          ‒  nvim-ufo 1.71ms
            ●  promise-async 0.1ms
        ★  start  rainbow-delimiters.nvim 0.27ms
          ‒  rainbow-delimiters.nvim/plugin/rainbow-delimiters.lua 0.06ms
        ★  start  LuaSnip 4.29ms
          ‒  LuaSnip/plugin/luasnip.lua 4.07ms
          ‒  LuaSnip/plugin/luasnip.vim 0.03ms
        ★  start  bufferline.nvim 3.82ms
          ‒  nvim-web-devicons 2.5ms
            ●  nvim-web-devicons/plugin/nvim-web-devicons.vim 0.04ms
        ★  start  mason.nvim 0.99ms
        ★  start  lualine.nvim 3.51ms
        ★  start  toggleterm.nvim 1.57ms
      ➜  rtp plugins 1.38ms
        ★  runtime/plugin/editorconfig.lua 0.05ms
        ★  runtime/plugin/gzip.vim 0.1ms
        ★  runtime/plugin/man.lua 0.04ms
        ★  runtime/plugin/matchit.vim 0.24ms
        ★  runtime/plugin/matchparen.vim 0.09ms
        ★  runtime/plugin/netrwPlugin.vim 0.24ms
        ★  runtime/plugin/osc52.lua 0.06ms
        ★  runtime/plugin/rplugin.vim 0.08ms
        ★  runtime/plugin/shada.vim 0.04ms
        ★  runtime/plugin/spellfile.vim 0.02ms
        ★  runtime/plugin/tarPlugin.vim 0.05ms
        ★  runtime/plugin/tohtml.lua 0.17ms
        ★  runtime/plugin/tutor.vim 0.03ms
        ★  runtime/plugin/zipPlugin.vim 0.09ms
      ➜  after 0.05ms
    ●  BufReadPre 1.47ms
      ➜  conform.nvim 1.33ms
        ★  conform.nvim/plugin/conform.lua 0.13ms
    ●  BufRead 0.37ms
      ➜  nvim-lastplace 0.27ms
      ➜  NvimLastplace 0.01ms
    ●  BufReadPost 0.28ms
      ➜  nvim-lint 0.21ms
      ➜  nvim-lint 0.01ms
    ●  markdown 57.61ms
      ➜  mdeval.nvim 0.25ms
        ★  mdeval.nvim/plugin/mdeval.vim 0.03ms
      ➜  render-markdown.nvim 3.69ms
        ★  nvim-treesitter 1.51ms
          ‒  nvim-treesitter/plugin/nvim-treesitter.lua 1.4ms
        ★  mini.icons 0.95ms
        ★  render-markdown.nvim/plugin/render-markdown.lua 0.98ms
      ➜  img-clip.nvim 0.48ms
        ★  img-clip.nvim/plugin/img-clip.lua 0.37ms
      ➜  mermaid.vim 0.06ms
      ➜  vim-markdown-toc 0.14ms
      ➜  obsidian.nvim 18.79ms
        ★  plenary.nvim 0.17ms
          ‒  plenary.nvim/plugin/plenary.vim 0.04ms
        ★  telescope.nvim 3.96ms
          ‒  telescope.nvim/plugin/telescope.lua 0.15ms
        ★  nvim-cmp 11.19ms
          ‒  cmp-nvim-lsp 0.44ms
            ●  after/plugin/cmp_nvim_lsp.lua 0.26ms
          ‒  cmp-buffer 4.33ms
            ●  after/plugin/cmp_buffer.lua 4.28ms
          ‒  cmp-path 0.28ms
            ●  after/plugin/cmp_path.lua 0.23ms
          ‒  cmp_luasnip 0.58ms
            ●  after/plugin/cmp_luasnip.lua 0.55ms
          ‒  friendly-snippets 0.03ms
          ‒  nvim-cmp/plugin/cmp.lua 0.31ms
      ➜  FileType 33.97ms
    ●  VimEnter 7.94ms
      ➜  dashboard-nvim 7.85ms
        ★  nvim-tree.lua 7.4ms
        ★  dashboard-nvim/plugin/dashboard.lua 0.09ms
      ➜  dashboard 0.02ms
    ●  startuptime 115.25ms
    ●  VeryLazy 30.45ms
      ➜  flash.nvim 0.94ms
      ➜  image.nvim 19.01ms
      ➜  indent-blankline.nvim 1.82ms
        ★  after/plugin/commands.lua 1.05ms
      ➜  gitsigns.nvim 3.73ms
        ★  gitsigns.nvim/plugin/gitsigns.lua 3.54ms
      ➜  nvim-notify 2.74ms
      ➜  which-key.nvim 0.37ms
        ★  which-key.nvim/plugin/which-key.lua 0.05ms
      ➜  lazygit.nvim 0.22ms
        ★  lazygit.nvim/plugin/lazygit.vim 0.12ms
