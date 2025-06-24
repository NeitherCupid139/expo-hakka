#!/bin/bash

# ExpoHakka Android Maestro 测试运行脚本

set -e

echo "🤖 开始运行 Android 平台的 Maestro 测试..."

# 检查 Maestro 是否安装
if ! command -v maestro &> /dev/null; then
    echo "❌ Maestro 未安装。请先安装 Maestro CLI。"
    exit 1
fi

# 检查 Android 设备/模拟器
echo "📱 检查 Android 设备连接..."
if ! adb devices | grep -q "device$"; then
    echo "❌ 未检测到 Android 设备或模拟器。"
    echo "请启动 Android 模拟器或连接 Android 设备。"
    exit 1
fi

# 创建 Android 截图目录
mkdir -p screenshots/android

# 设置环境变量
export PLATFORM=android

echo "🧪 运行 Android 基础功能测试..."
maestro test --config config/android.yaml flows/basic/app-launch.yaml
maestro test --config config/android.yaml flows/basic/navigation.yaml

echo "🔧 运行 Android 工具栏测试..."
maestro test --config config/android.yaml flows/toolbar/standard-toolbar.yaml
maestro test --config config/android.yaml flows/toolbar/custom-toolbar.yaml
maestro test --config config/android.yaml flows/toolbar/toolbar-interactions.yaml

echo "🔍 运行 Android 回归测试..."
maestro test --config config/android.yaml flows/regression/smoke-test.yaml

echo "✅ Android 测试完成！"
echo "📸 Android 截图保存在 screenshots/android/ 目录中"
