#!/bin/bash

echo "===== 工作空间结构验证 ====="
echo "检查时间: $(date)"
echo "当前目录: $(pwd)"
echo ""

# 1. 基础检查
echo "1. 基础文件检查:"
echo "----------------"
if [ -f "COURSE" ]; then
    COURSE_CONTENT=$(cat COURSE | tr -d '\n')
    echo "✓ COURSE 文件存在"
    echo "  内容: '$COURSE_CONTENT'"
    if [ "$COURSE_CONTENT" = "arch-pc" ]; then
        echo "  ✓ 内容正确 (arch-pc)"
    else
        echo "  ✗ 内容不正确 (应为 'arch-pc')"
    fi
else
    echo "✗ COURSE 文件缺失"
fi

echo -e "\n2. 主要目录检查:"
echo "----------------"
for dir in labs docs; do
    if [ -d "$dir" ]; then
        echo "✓ $dir/ 目录存在"
        echo "  包含项目: $(ls -1 $dir/ 2>/dev/null | wc -l)"
    else
        echo "✗ $dir/ 目录缺失"
    fi
done

echo -e "\n3. 实验目录详细检查:"
echo "----------------"
for lab_num in 01 02 03; do
    lab_dir="labs/lab$lab_num"
    if [ -d "$lab_dir" ]; then
        echo "✓ $lab_dir/ 存在"
        
        # 检查report目录
        if [ -d "$lab_dir/report" ]; then
            echo "  ✓ $lab_dir/report/ 存在"
        else
            echo "  ✗ $lab_dir/report/ 缺失"
        fi
        
        # 列出目录内容
        echo "  内容: $(ls -1 $lab_dir/ 2>/dev/null | tr '\n' ' ')"
    else
        echo "✗ $lab_dir/ 缺失"
    fi
done

echo -e "\n4. Git状态检查:"
echo "----------------"
if [ -d ".git" ]; then
    echo "✓ 是Git仓库"
    BRANCH=$(git branch --show-current 2>/dev/null || echo "未知")
    echo "  当前分支: $BRANCH"
    
    REMOTE=$(git remote -v 2>/dev/null | head -1)
    if [ -n "$REMOTE" ]; then
        echo "  远程仓库: $REMOTE"
    else
        echo "  ✗ 无远程仓库配置"
    fi
    
    # 检查是否有未提交的更改
    CHANGES=$(git status --porcelain 2>/dev/null | wc -l)
    if [ "$CHANGES" -gt 0 ]; then
        echo "  ⚠ 有未提交的更改 ($CHANGES 个文件)"
    else
        echo "  ✓ 工作区干净"
    fi
else
    echo "✗ 不是Git仓库"
fi

echo -e "\n5. 结构总结:"
echo "----------------"
echo "总目录数: $(find . -type d | wc -l)"
echo "总文件数: $(find . -type f | wc -l)"
echo "结构深度:"
find . -type d | awk -F/ '{print NF-1}' | sort -n | tail -1 | xargs -I {} echo "  {} 层"

echo -e "\n===== 验证完成 ====="
