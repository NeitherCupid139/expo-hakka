#!/bin/bash

# ExpoHakka iOS Maestro 测试运行脚本

set -e

echo "🍎 开始运行 iOS 平台的 Maestro 测试..."

# 检查 Maestro 是否安装
if ! command -v maestro &> /dev/null; then
    echo "❌ Maestro 未安装。请先安装 Maestro CLI。"
    exit 1
fi

# 检查 iOS 设备/模拟器
echo "📱 检查 iOS 设备连接..."
if ! xcrun simctl list devices | grep -q "Booted"; then
    echo "❌ 未检测到运行中的 iOS 模拟器。"
    echo "请启动 iOS 模拟器或连接 iOS 设备。"
    exit 1
fi

# 创建 iOS 截图目录
mkdir -p screenshots/ios

# 设置环境变量
export PLATFORM=ios

echo "🧪 运行 iOS 基础功能测试..."
maestro test --config config/ios.yaml flows/basic/app-launch.yaml
maestro test --config config/ios.yaml flows/basic/navigation.yaml

echo "🔧 运行 iOS 工具栏测试..."
maestro test --config config/ios.yaml flows/toolbar/standard-toolbar.yaml
maestro test --config config/ios.yaml flows/toolbar/custom-toolbar.yaml
maestro test --config config/ios.yaml flows/toolbar/toolbar-interactions.yaml

echo "🔍 运行 iOS 回归测试..."
maestro test --config config/ios.yaml flows/regression/smoke-test.yaml

echo "✅ iOS 测试完成！"
echo "📸 iOS 截图保存在 screenshots/ios/ 目录中"
