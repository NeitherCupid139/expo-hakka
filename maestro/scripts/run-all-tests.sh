#!/bin/bash

# ExpoHakka Maestro 测试运行脚本
# 运行所有 Maestro 测试

set -e

echo "🚀 开始运行 ExpoHakka Maestro 测试..."

# 检查 Maestro 是否安装
if ! command -v maestro &> /dev/null; then
    echo "❌ Maestro 未安装。请先安装 Maestro CLI。"
    echo "安装命令: curl -Ls \"https://get.maestro.mobile.dev\" | bash"
    exit 1
fi

# 检查设备连接
echo "📱 检查设备连接..."
if ! maestro test --help &> /dev/null; then
    echo "❌ 无法连接到设备。请确保设备已连接并启用了开发者模式。"
    exit 1
fi

# 创建截图目录
mkdir -p screenshots/android screenshots/ios

echo "🧪 运行基础功能测试..."
maestro test flows/basic/app-launch.yaml
maestro test flows/basic/navigation.yaml

echo "🔧 运行工具栏测试..."
maestro test flows/toolbar/standard-toolbar.yaml
maestro test flows/toolbar/custom-toolbar.yaml
maestro test flows/toolbar/toolbar-interactions.yaml

echo "🔍 运行回归测试..."
maestro test flows/regression/smoke-test.yaml

echo "✅ 所有测试完成！"
echo "📸 截图保存在 screenshots/ 目录中"
