# Valgrind 简洁使用指南

## 基础使用

### 1. 基本内存检查

```bash
valgrind ./your_program
```

### 2. 详细内存泄漏检测

```bash
valgrind --leak-check=full --show-leak-kinds=all ./your_program
```

### 3. 带源码位置显示

```bash
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./your_program
```

## 编译要求

编译时**必须**添加 `-g` 选项：

```bash
gcc -g -o your_program your_program.c
g++ -g -o your_program your_program.cpp
```

## 快速检测脚本

创建 `check_mem.sh`：

```bash
#!/bin/bash
gcc -g -o $1 $1.c
valgrind --leak-check=full --show-leak-kinds=all ./$1
```

使用：`./check_mem.sh your_program`

## 结果解读重点

- ** definitely lost**：确认内存泄漏 - 必须修复
- ** indirectly lost**：间接内存泄漏 - 必须修复
- ** possibly lost**：可能的内存泄漏 - 建议修复
- ** still reachable**：程序结束时仍未释放 - 低优先级
- ** Invalid read/write**：非法内存访问 - 严重错误

## 实用技巧

### 只关注错误，忽略系统库

```bash
valgrind --leak-check=full --show-leak-kinds=all --errors-for-leak-kinds=all --error-exitcode=1 ./your_program
```

### 生成日志文件

```bash
valgrind --log-file=valgrind.log --leak-check=full ./your_program
```

## 快速检查流程

1. 编译：`gcc -g -o test test.c`
2. 运行：`valgrind --leak-check=full ./test`
3. 重点关注：**definitely lost** 和 **Invalid read/write**
