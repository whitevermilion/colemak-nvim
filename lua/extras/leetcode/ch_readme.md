# leetcode.nvim

🔥 在 Neovim 中解决 LeetCode 问题 🔥

## ✨ 特性

- 📌 直观的仪表板，轻松导航
- 😍 格式化的问题描述，提高可读性
- 📈 在 Neovim 中查看 LeetCode 个人资料统计
- 🔀 支持每日和随机题目
- 💾 缓存优化性能

## 📬 要求

- Neovim >= 0.9.0
- 选择器（见选择器部分）
- plenary.nvim
- nui.nvim
- tree-sitter-html（可选，但强烈推荐）
- Nerd Font & nvim-web-devicons（可选）

## 📦 安装

### 使用 lazy.nvim

```lua
{
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- 配置写在这里
    },
}
```

## 🛠️ 配置

### 默认配置

```lua
{
    arg = "leetcode.nvim",
    lang = "cpp",
    cn = {
        enabled = false,
        translator = true,
        translate_problems = true,
    },
    storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    -- ... 更多配置
}
```

### 支持的语言

| 语言       | 代码       |
| ---------- | ---------- |
| C++        | cpp        |
| Java       | java       |
| Python     | python     |
| Python3    | python3    |
| C          | c          |
| C#         | csharp     |
| JavaScript | javascript |
| TypeScript | typescript |
| PHP        | php        |
| Swift      | swift      |
| Kotlin     | kotlin     |
| Dart       | dart       |
| Go         | golang     |
| Ruby       | ruby       |
| Scala      | scala      |
| Rust       | rust       |

### 选择器支持

支持的选择器提供程序：

- `snacks-picker`
- `fzf-lua`
- `telescope`
- `mini-picker`

## 📋 命令

### 主要命令

- `Leet` - 打开菜单仪表板
- `Leet menu` - 同 `Leet`
- `Leet exit` - 关闭 leetcode.nvim
- `Leet console` - 为当前题目打开控制台
- `Leet info` - 显示当前题目信息

### 题目管理

- `Leet tabs` - 显示所有已打开的题目标签页
- `Leet yank` - 复制代码部分
- `Leet lang` - 更改当前题目的语言
- `Leet run` - 运行当前题目
- `Leet test` - 同 `Leet run`
- `Leet submit` - 提交当前题目

### 导航

- `Leet random` - 打开随机题目
- `Leet daily` - 打开今日每日一题
- `Leet list` - 显示所有可用题目
- `Leet open` - 在浏览器中打开当前题目

### 代码管理

- `Leet restore` - 恢复默认题目布局
- `Leet last_submit` - 用最后提交的代码替换
- `Leet reset` - 重置为默认代码片段
- `Leet inject` - 重新注入代码导入
- `Leet fold` - 折叠导入部分

### 描述和缓存

- `Leet desc` - 切换题目描述显示
- `Leet desc stats` - 切换统计信息显示
- `Leet cookie update` - 更新 cookie
- `Leet cookie delete` - 删除 cookie 并登出
- `Leet cache update` - 更新本地缓存

## 🚀 使用方法

### 方法 1：使用参数启动

```bash
nvim leetcode.nvim
```

### 方法 2：使用 :Leet 命令

```vim
:Leet
```

### 登录

要登录，您需要提供 LeetCode cookie：

1. 在浏览器中打开 LeetCode
2. 从请求头中复制 `Cookie`（不是 `set-cookie`）
3. 运行 `:Leet cookie update` 并粘贴 cookie

## ❓ 常见问题

### Cookie 过期错误

如果您收到 "cookie expired" 错误，通常意味着：

- LeetCode 负载较重（比赛期间）
- 如果使用 VPN，请尝试禁用
- 等待并稍后重试

### 切换测试用例

按下与测试用例对应的数字键：

- `1` 对应 Case (1)
- `2` 对应 Case (2)
- 等等

### 切换题目

使用 `Leet tabs` 在已打开的题目之间切换。

### LSP 自动补全

某些语言需要额外的设置才能获得 LSP 自动补全。请查看插件问题以获取特定语言的配置。

## 🍴 使用示例

### 使用 lazy.nvim 延迟加载

```lua
-- 方法 1：使用参数
local leet_arg = "leetcode.nvim"
{
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    opts = { arg = leet_arg },
}

-- 方法 2：使用命令
{
    "kawre/leetcode.nvim",
    cmd = "Leet",
}
```

### 非独立模式

要在非独立模式下运行（不在空的 Neovim 会话中）：

```lua
plugins = {
  non_standalone = true,
}
```

使用 `:Leet exit` 退出

## 🪟 Windows 用户

推荐使用 Cygwin 以获得一致的类 Unix 体验。

## 🙌 致谢

- Leetbuddy.nvim
- alpha-nvim
