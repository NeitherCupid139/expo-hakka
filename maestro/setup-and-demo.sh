#!/bin/bash

# ExpoHakka Maestro 设置和演示脚本

set -e

echo "🎯 ExpoHakka Maestro 测试设置和演示"
echo "======================================"

# 检查是否在正确的目录
if [ ! -f "README.md" ]; then
    echo "❌ 请在 maestro 目录中运行此脚本"
    exit 1
fi

# 1. 检查 Maestro 安装
echo "📦 检查 Maestro 安装状态..."
if command -v maestro &> /dev/null; then
    echo "✅ Maestro 已安装: $(maestro --version)"
else
    echo "⚠️  Maestro 未安装，正在安装..."
    curl -Ls "https://get.maestro.mobile.dev" | bash
    
    # 添加到 PATH
    export PATH="$HOME/.maestro/bin:$PATH"
    
    if command -v maestro &> /dev/null; then
        echo "✅ Maestro 安装成功: $(maestro --version)"
    else
        echo "❌ Maestro 安装失败，请手动安装"
        echo "安装命令: curl -Ls \"https://get.maestro.mobile.dev\" | bash"
        exit 1
    fi
fi

# 2. 检查设备连接
echo ""
echo "📱 检查设备连接..."

# 检查 Android 设备
if command -v adb &> /dev/null; then
    ANDROID_DEVICES=$(adb devices | grep -c "device$" || true)
    if [ "$ANDROID_DEVICES" -gt 0 ]; then
        echo "✅ 检测到 $ANDROID_DEVICES 个 Android 设备"
        ANDROID_AVAILABLE=true
    else
        echo "⚠️  未检测到 Android 设备"
        ANDROID_AVAILABLE=false
    fi
else
    echo "⚠️  ADB 未安装，无法检测 Android 设备"
    ANDROID_AVAILABLE=false
fi

# 检查 iOS 设备
if command -v xcrun &> /dev/null; then
    IOS_DEVICES=$(xcrun simctl list devices | grep -c "Booted" || true)
    if [ "$IOS_DEVICES" -gt 0 ]; then
        echo "✅ 检测到 $IOS_DEVICES 个 iOS 设备"
        IOS_AVAILABLE=true
    else
        echo "⚠️  未检测到运行中的 iOS 模拟器"
        IOS_AVAILABLE=false
    fi
else
    echo "⚠️  Xcode 工具未安装，无法检测 iOS 设备"
    IOS_AVAILABLE=false
fi

# 3. 创建必要的目录
echo ""
echo "📁 创建测试目录..."
mkdir -p screenshots/android screenshots/ios

# 4. 验证测试文件
echo ""
echo "📋 验证测试文件..."
TEST_FILES=(
    "flows/basic/app-launch.yaml"
    "flows/basic/navigation.yaml"
    "flows/toolbar/standard-toolbar.yaml"
    "flows/toolbar/custom-toolbar.yaml"
    "flows/toolbar/toolbar-interactions.yaml"
    "flows/regression/smoke-test.yaml"
)

for file in "${TEST_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file 缺失"
    fi
done

# 5. 运行演示测试
echo ""
echo "🧪 准备运行演示测试..."

if [ "$ANDROID_AVAILABLE" = true ] || [ "$IOS_AVAILABLE" = true ]; then
    echo ""
    echo "选择要运行的测试:"
    echo "1) 快速冒烟测试 (推荐)"
    echo "2) 应用启动测试"
    echo "3) 导航测试"
    echo "4) 工具栏测试"
    echo "5) 跳过测试"
    
    read -p "请选择 (1-5): " choice
    
    case $choice in
        1)
            echo "🚀 运行冒烟测试..."
            maestro test flows/regression/smoke-test.yaml
            ;;
        2)
            echo "🚀 运行应用启动测试..."
            maestro test flows/basic/app-launch.yaml
            ;;
        3)
            echo "🚀 运行导航测试..."
            maestro test flows/basic/navigation.yaml
            ;;
        4)
            echo "🚀 运行工具栏测试..."
            maestro test flows/toolbar/standard-toolbar.yaml
            ;;
        5)
            echo "⏭️  跳过测试"
            ;;
        *)
            echo "❌ 无效选择"
            ;;
    esac
else
    echo "⚠️  未检测到可用设备，无法运行测试"
    echo ""
    echo "请按照以下步骤准备设备:"
    echo "Android: 启动 Android 模拟器或连接 Android 设备"
    echo "iOS: 启动 iOS 模拟器或连接 iOS 设备"
fi

# 6. 显示使用说明
echo ""
echo "📚 使用说明:"
echo "============"
echo ""
echo "运行所有测试:"
echo "  ./scripts/run-all-tests.sh"
echo ""
echo "运行特定平台测试:"
echo "  ./scripts/run-android-tests.sh"
echo "  ./scripts/run-ios-tests.sh"
echo ""
echo "运行单个测试:"
echo "  maestro test flows/basic/app-launch.yaml"
echo ""
echo "使用 npm/bun 脚本 (在 example 目录中):"
echo "  bun run test:maestro"
echo "  bun run test:maestro:android"
echo "  bun run test:maestro:ios"
echo "  bun run test:maestro:smoke"
echo ""
echo "查看详细文档:"
echo "  cat TESTING_GUIDE.md"
echo ""
echo "✅ 设置完成！"
