#!/bin/bash

# 设置 UTF-8 编码
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# 进入脚本所在目录
cd "$(dirname "$0")"

echo "博客园 Markdown 上传工具"
echo "========================"

while true; do
    echo
    read -p "请拖入要上传的md文件 (或输入 'quit' 退出): " filePath
    
    # 检查是否要退出
    if [[ "$filePath" == "quit" ]] || [[ "$filePath" == "exit" ]]; then
        echo "程序已退出"
        break
    fi
    
    # 检查文件是否存在
    if [[ ! -f "$filePath" ]]; then
        echo "错误: 文件不存在 - $filePath"
        continue
    fi
    
    # 检查是否为 Markdown 文件
    if [[ "${filePath##*.}" != "md" ]] && [[ "${filePath##*.}" != "markdown" ]]; then
        echo "警告: 文件可能不是 Markdown 格式"
    fi
    
    echo "正在上传文件: $filePath"
    echo "------------------------"
    
    # 执行上传脚本
    python3 upload.py "$filePath"
    
    # 检查执行结果
    if [[ $? -eq 0 ]]; then
        echo "上传完成!"
    else
        echo "上传失败，请检查错误信息"
    fi
    
    echo
    echo "按 Enter 键继续..."
    read -p ""
done
