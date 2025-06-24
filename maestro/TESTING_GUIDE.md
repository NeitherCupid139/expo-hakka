# ExpoHakka Maestro Testing Guide

## Overview

This guide explains how to use Maestro for UI automation testing of the ExpoHakka project. Maestro is a simple yet powerful mobile UI testing framework, particularly suitable for testing React Native and Expo applications.

## Installing Maestro

### Method 1: Using Installation Script (Recommended)

```bash
curl -Ls "https://get.maestro.mobile.dev" | bash
```

### Method 2: Using Homebrew

```bash
brew tap mobile-dev-inc/tap
brew install maestro
```

### Verify Installation

```bash
maestro --version
```

## Environment Setup

### Android Testing

1. Start Android emulator or connect Android device
2. Ensure ADB can detect the device:
   ```bash
   adb devices
   ```
3. Build and install app on device:
   ```bash
   cd example
   bun run android
   ```

### iOS Testing

1. Start iOS simulator or connect iOS device
2. Ensure device is available:
   ```bash
   xcrun simctl list devices
   ```
3. Build and install app on device:
   ```bash
   cd example
   bun run ios
   ```

## Running Tests

### Using npm/bun Scripts (Recommended)

```bash
cd example

# Run all tests
bun run test:maestro

# Run Android tests
bun run test:maestro:android

# Run iOS tests
bun run test:maestro:ios

# Run quick smoke tests
bun run test:maestro:smoke
```

### Direct Maestro Commands

```bash
cd maestro

# Run individual test file
maestro test flows/basic/app-launch.yaml

# Run platform-specific tests
maestro test --config config/android.yaml flows/basic/app-launch.yaml

# Run all tests
./scripts/run-all-tests.sh
```

## Test Structure Explanation

### Basic Tests (flows/basic/)

- **app-launch.yaml**: Verify app launch and basic element display
- **navigation.yaml**: Test scrolling and navigation functionality

### Toolbar Tests (flows/toolbar/)

- **standard-toolbar.yaml**: Test standard toolbar functionality
- **custom-toolbar.yaml**: Test custom toolbar functionality
- **toolbar-interactions.yaml**: Comprehensive toolbar interaction tests

### Regression Tests (flows/regression/)

- **smoke-test.yaml**: Quick smoke tests to verify core functionality

## Testing Key Points

### Toolbar Testing Considerations

Since ExpoHakka uses SwiftUI components, toolbar buttons may not have traditional accessibility identifiers. Tests use the following strategies:

1. **Coordinate Clicking**: Use relative coordinates to click toolbar areas
2. **Alert Verification**: Verify Alert popups after button clicks
3. **Visual Verification**: Verify through screenshots and element visibility

### Common Issue Resolution

#### 1. Element Not Found

- Ensure app is fully loaded
- Check if element text is correct
- Try using coordinate clicking

#### 2. Test Timeout

- Increase wait time
- Check device performance
- Ensure stable network connection

#### 3. Popup Handling

- Use `runFlow` conditional execution
- Add appropriate wait times
- Handle multiple consecutive popups

## Best Practices

### 1. Test Stability

- Add appropriate wait times
- Use conditional execution for optional elements
- Add retry mechanisms

### 2. Test Maintenance

- Keep tests simple and clear
- Use descriptive test names
- Regularly update test cases

### 3. Debugging Tips

- Use screenshots to record test states
- Add detailed assertion information
- Verify test flow step by step

## Continuous Integration

### GitHub Actions Example

```yaml
name: Maestro Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Maestro
        run: curl -Ls "https://get.maestro.mobile.dev" | bash
      - name: Run tests
        run: |
          cd example
          bun install
          bun run test:maestro:smoke
```

## Troubleshooting

### Common Errors and Solutions

1. **"maestro: command not found"**

   - Ensure Maestro is properly installed
   - Check PATH environment variable

2. **"No devices found"**

   - Ensure device/emulator is started
   - Check ADB/iOS device connection

3. **"App not found"**

   - Ensure app is installed on device
   - Check app package name/Bundle ID

4. **Test Instability**
   - Increase wait times
   - Use more reliable element locating methods
   - Add retry logic
