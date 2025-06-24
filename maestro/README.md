# Maestro UI Testing

This directory contains Maestro UI tests for the ExpoHakka project.

## Directory Structure

```
maestro/
├── README.md                 # This document
├── config/                   # Test configuration files
│   ├── android.yaml         # Android-specific configuration
│   └── ios.yaml             # iOS-specific configuration
├── flows/                   # Test flow files
│   ├── basic/               # Basic functionality tests
│   │   ├── app-launch.yaml  # App launch tests
│   │   └── navigation.yaml  # Navigation tests
│   ├── toolbar/             # Toolbar-related tests
│   │   ├── standard-toolbar.yaml    # Standard toolbar tests
│   │   ├── custom-toolbar.yaml     # Custom toolbar tests
│   │   └── toolbar-interactions.yaml # Toolbar interaction tests
│   └── regression/          # Regression tests
│       └── smoke-test.yaml  # Smoke tests
└── scripts/                 # Test scripts
    ├── run-all-tests.sh     # Run all tests
    ├── run-android-tests.sh # Run Android tests
    └── run-ios-tests.sh     # Run iOS tests
```

## Prerequisites

1. Install Maestro CLI
2. Start Android emulator or connect iOS device
3. Build and install app on device

## Running Tests

### Run All Tests

```bash
cd maestro
./scripts/run-all-tests.sh
```

### Run Platform-Specific Tests

```bash
# Android
./scripts/run-android-tests.sh

# iOS
./scripts/run-ios-tests.sh
```

### Run Individual Test Flow

```bash
maestro test flows/basic/app-launch.yaml
```

## Test Coverage

- ✅ App launch and basic navigation
- ✅ Standard toolbar functionality tests
- ✅ Custom toolbar functionality tests
- ✅ Toolbar button interaction tests
- ✅ Regression tests and smoke tests

## Notes

- Ensure device/emulator is connected and accessible
- Make sure app is properly installed before testing
- Some tests may require specific device state or data
