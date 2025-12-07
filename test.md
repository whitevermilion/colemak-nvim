## 1. 静态分析工具

### C/C++ 项目

```bash
# Clang 静态分析
clang-tidy your_code.c
scan-build gcc -g your_code.c

# CPPCheck
cppcheck --enable=all your_code.c

# 代码复杂度分析
pmccabe your_code.c
```

### 通用代码质量

```bash
# 代码格式检查
clang-format -n your_code.c    # 只检查不修改
clang-format -i your_code.c    # 自动修复

# 头文件依赖检查
include-what-you-use your_code.c
```

## 2. 编译时检查

### GCC/Clang 严格模式

```bash
# 推荐编译选项
gcc -Wall -Wextra -Wpedantic -Werror -g -O0 your_code.c

# 更严格的检查
gcc -Wall -Wextra -Wpedantic -Werror \
    -Wshadow -Wconversion -Wdouble-promotion \
    -Wformat=2 -Wnull-dereference -g your_code.c
```

## 3. 动态分析工具

### AddressSanitizer (ASan)

```bash
gcc -fsanitize=address -g your_code.c
./a.out  # 会自动检测内存错误
```

### UndefinedBehaviorSanitizer (UBSan)

```bash
gcc -fsanitize=undefined -g your_code.c
```

## 4. 测试覆盖度

### Gcov 覆盖度分析

```bash
gcc -fprofile-arcs -ftest-coverage -g your_code.c
./a.out
gcov your_code.c
```

## 5. Neovim 集成配置

在 `init.vim` 中添加：

```vim
" 代码检查插件
Plug 'dense-analysis/ale'

" ALE 配置
let g:ale_linters = {
\   'c': ['clangtidy', 'cppcheck', 'gcc'],
\   'cpp': ['clangtidy', 'cppcheck', 'g++'],
\}

let g:ale_c_clangtidy_checks = ['*']
let g:ale_cpp_clangtidy_checks = ['*']

" 编译命令快捷键
nnoremap <leader>cc :!gcc -Wall -Wextra -Wpedantic -g % -o %:r<CR>
nnoremap <leader>cv :!valgrind --leak-check=full ./%:r<CR>
nnoremap <leader>ct :!clang-tidy %<CR>
```

## 6. 快速检测脚本

创建 `quality_check.sh`：

```bash
#!/bin/bash
file=$1

echo "=== 代码格式检查 ==="
clang-format -n $file

echo "=== 静态分析 ==="
clang-tidy $file
cppcheck --enable=all $file

echo "=== 编译检查 ==="
gcc -Wall -Wextra -Wpedantic -Werror -g $file -o ${file%.*}

echo "=== 内存检查 ==="
valgrind --leak-check=full ./${file%.*}
```

## 7. 代码质量检查清单

- [ ] 编译无警告 (`-Wall -Wextra -Wpedantic`)
- [ ] 静态分析通过 (`clang-tidy`, `cppcheck`)
- [ ] 内存无泄漏 (`valgrind`)
- [ ] 无未定义行为 (`-fsanitize=undefined`)
- [ ] 无内存错误 (`-fsanitize=address`)
- [ ] 代码格式规范 (`clang-format`)
- [ ] 测试覆盖度达标 (`gcov`)

## 8. 一键检测命令

```bash
# 保存为 check_all.sh
gcc -Wall -Wextra -Wpedantic -g -fsanitize=address $1 -o test && \
clang-tidy $1 && \
valgrind --leak-check=full ./test
```
