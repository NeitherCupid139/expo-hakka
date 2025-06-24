# expo-hakka

🛠️ **SwiftUI Toolbar for Expo** - Use native iOS SwiftUI Toolbar components in Expo projects

[![npm version](https://badge.fury.io/js/expo-hakka.svg)](https://badge.fury.io/js/expo-hakka)
[![Platform - iOS](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0+-orange.svg)](https://developer.apple.com/xcode/swiftui/)

## 📖 Introduction

`expo-hakka` is a native module specifically designed for Expo projects, enabling you to use native iOS SwiftUI Toolbar components in React Native applications. It provides a simple and easy-to-use API for quickly creating feature-rich toolbars.

### ✨ Features

- 🎯 **Native SwiftUI Toolbar** - 100% native iOS toolbar experience
- 🚀 **Universal API** - Flexible configuration for left, center, and right toolbar areas
- 🔧 **Complete Toolbar Functionality** - Supports buttons, menus, sorting, layout switching, and more
- 🎨 **Preset Styles** - Ready-to-use styles based on your toolbar code
- 📱 **Responsive Design** - Automatically adapts to different screen sizes
- 🔄 **Event Handling** - Simplified event handling mechanism
- 🛡️ **Type Safety** - Complete TypeScript type definitions
- ⚡ **High Performance** - Focused on iOS platform, web support removed for better performance

## 🚀 Installation

Install with bun:

```bash
cd your-expo-project
bun add expo-hakka
```

Install with npm:

```bash
npm install expo-hakka
```

Install with yarn:

```bash
yarn add expo-hakka
```

## 📋 Requirements

- Expo SDK 49+
- iOS 14.0+
- React Native 0.70+
- TypeScript 4.0+ (recommended)

## 🎯 Quick Start

### Basic Toolbar

Create a simple toolbar with title and buttons:

```tsx
import React from "react";
import { ExpoHakkaView, createToolbar, Button } from "expo-hakka";
import { Alert, StyleSheet, View } from "react-native";

export default function App() {
	const toolbar = createToolbar({
		center: "My App",
		leadingButtons: [
			Button("profile", "Profile", "person.crop.circle.fill", () =>
				Alert.alert("Profile", "Open Profile")
			),
		],
		trailingButtons: [
			Button("add", "Add", "plus", () => Alert.alert("Add", "Add New Item")),
			Button("search", "Search", "magnifyingglass", () =>
				Alert.alert("Search", "Open Search")
			),
		],
	});

	return (
		<View style={styles.container}>
			<ExpoHakkaView toolbar={toolbar} style={styles.toolbarView} />
		</View>
	);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: "#fff",
	},
	toolbarView: {
		flex: 1,
		height: 400,
	},
});
```

### Custom Center Component

Create a toolbar with custom center component overlay:

```tsx
import React from "react";
import { ExpoHakkaView, createToolbar, Button } from "expo-hakka";
import { Alert, StyleSheet, View, Text } from "react-native";

export default function App() {
	// Toolbar with custom center component
	const toolbar = createToolbar({
		center: (
			<View style={styles.customCenter}>
				<Text style={styles.customCenterText}>🎯 Custom Center</Text>
			</View>
		),
		leadingButtons: [
			Button("menu", "Menu", "line.horizontal.3", () =>
				Alert.alert("Menu", "Open Menu")
			),
		],
		trailingButtons: [
			Button("notifications", "Notifications", "bell", () =>
				Alert.alert("Notifications", "View Notifications")
			),
		],
	});

	return (
		<View style={styles.container}>
			<ExpoHakkaView toolbar={toolbar} style={styles.toolbarView} />
		</View>
	);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: "#fff",
	},
	toolbarView: {
		flex: 1,
		height: 400,
	},
	customCenter: {
		backgroundColor: "rgba(0, 122, 255, 0.1)",
		paddingHorizontal: 16,
		paddingVertical: 4,
		borderRadius: 12,
	},
	customCenterText: {
		fontSize: 16,
		fontWeight: "600",
		color: "#007AFF",
	},
});
```

## 📚 API Documentation

### ExpoHakkaView Component

The main toolbar view component.

#### Props

| Property Name          | Type                                       | Required | Description                        |
| ---------------------- | ------------------------------------------ | -------- | ---------------------------------- |
| `toolbar`              | `ToolbarConfig`                            | No       | Universal toolbar configuration    |
| `onToolbarButtonPress` | `(event: ToolbarButtonPressEvent) => void` | No       | Toolbar button press event handler |
| `style`                | `StyleProp<ViewStyle>`                     | No       | View style                         |

### Core API Functions

#### createToolbar

Creates a universal toolbar configuration with flexible left, center, and right areas.

```typescript
function createToolbar(config: {
	center?: React.ReactNode;
	leadingButtons?: ToolbarButton[];
	trailingButtons?: ToolbarButton[];
}): ToolbarConfig;
```

#### Button

Creates a toolbar button with simplified API.

```typescript
function Button(
	id: string,
	title: string,
	systemImage: string,
	onPress: () => void,
	options?: { isEnabled?: boolean }
): ToolbarButton;
```

#### ToolbarButton

Simple toolbar button configuration.

```typescript
interface ToolbarButton {
	/** Button unique identifier */
	id: string;
	/** Button title (for accessibility) */
	title: string;
	/** SF Symbols icon name */
	systemImage: string;
	/** Click event handler function */
	onPress: () => void;
	/** Whether enabled, defaults to true */
	isEnabled?: boolean;
}
```

### Configuration Types

#### ToolbarConfig

Universal toolbar configuration interface.

```typescript
interface ToolbarConfig {
	/** Center area - can be title string or React component */
	center?: React.ReactNode;
	/** Leading buttons (usually avatar, back button, etc.) */
	leadingButtons?: ToolbarButton[];
	/** Trailing button group (add, search, more, etc.) */
	trailingButtons?: ToolbarButton[];
}
```

### Event Types

#### ToolbarButtonPressEvent

Toolbar button press event.

```typescript
interface ToolbarButtonPressEvent {
	nativeEvent: {
		buttonId: string; // Button ID
		itemId?: string; // Menu item ID (menu items only)
		placement: ToolbarPlacement; // Toolbar placement
	};
}
```

## 🎨 Style Guide

### Button Styles

- `borderless` - Borderless style (default)
- `bordered` - Bordered style
- `plain` - Plain text style

### Navigation Bar Styles

- `default` - Default style
- `compact` - Compact style
- `large` - Large title style

### SF Symbols

Use Apple's SF Symbols as icons. Common icons include:

- `chevron.left` - Left arrow
- `gear` - Settings
- `plus` - Plus sign
- `ellipsis.circle` - More
- `house` - Home
- `heart` - Favorite
- `person` - Person
- `magnifyingglass` - Search
- `bell` - Notification

For a complete list of SF Symbols, refer to [Apple's official documentation](https://developer.apple.com/sf-symbols/).

## 💡 Best Practices

### 1. Toolbar Design Principles

- **Keep it Simple** - Avoid placing too many buttons in the toolbar
- **Use Standard Icons** - Prioritize using standard icons from SF Symbols
- **Consider Accessibility** - Provide `accessibilityLabel` for all buttons
- **Responsive Design** - Consider display effects on different screen sizes

### 2. Performance Optimization

```tsx
// Use useMemo to optimize toolbar configuration
const toolbarConfig = useMemo(
	() =>
		createToolbar({
			center: "My App",
			leadingButtons: [
				/* ... */
			],
			trailingButtons: [
				/* ... */
			],
		}),
	[
		/* dependencies */
	]
);

// Use useCallback to optimize event handlers
const handleToolbarButtonPress = useCallback((event) => {
	// Handle logic
}, []);
```

### 3. State Management

```tsx
// Use state to manage dynamic toolbar configuration
const [isEditing, setIsEditing] = useState(false);

const toolbarConfig = useMemo(
	() =>
		createToolbar({
			center: isEditing ? "Edit Mode" : "View Mode",
			trailingButtons: [
				Button(
					isEditing ? "save" : "edit",
					isEditing ? "Save" : "Edit",
					isEditing ? "checkmark" : "pencil",
					() => setIsEditing(!isEditing)
				),
			],
		}),
	[isEditing]
);
```

## 🧪 Testing

This project uses [Maestro](https://maestro.mobile.dev/) for UI automation testing to ensure the functionality and stability of toolbar components.

### Running Tests

#### Quick Start

```bash
cd example
bun run test:maestro:smoke  # Run quick smoke tests
```

#### Complete Test Suite

```bash
# Run all tests
bun run test:maestro

# Run platform-specific tests
bun run test:maestro:android  # Android tests
bun run test:maestro:ios      # iOS tests
```

#### Manual Maestro Test Execution

```bash
cd maestro

# Setup and demo
./setup-and-demo.sh

# Run specific tests
maestro test flows/basic/app-launch.yaml
maestro test flows/toolbar/standard-toolbar.yaml
```

### Test Coverage

- ✅ **App Launch Tests** - Verify app launches correctly and basic elements display
- ✅ **Navigation Tests** - Test scrolling and page navigation functionality
- ✅ **Basic Toolbar Tests** - Verify toolbar functionality created by `createSimpleToolbar`
- ✅ **Custom Toolbar Tests** - Test custom toolbar buttons and interactions
- ✅ **Toolbar Interaction Tests** - Comprehensive testing of toolbar button responses and event handling
- ✅ **Regression Tests** - Quick smoke tests to verify core functionality

### Test Environment Requirements

- Install [Maestro CLI](https://maestro.mobile.dev/)
- Android: Start Android emulator or connect device
- iOS: Start iOS simulator or connect device
- Ensure example app is built and installed on device

For detailed testing guide, see [maestro/TESTING_GUIDE.md](maestro/TESTING_GUIDE.md).

## 🔧 Troubleshooting

### Common Issues

#### 1. Toolbar Not Displaying

**Problem**: Toolbar configured correctly but not displaying

**Solutions**:

- Ensure `style` property has sufficient height
- Check if `toolbar` configuration is properly serialized
- Check console for error messages

```tsx
// Correct style setup
<ExpoHakkaView
	toolbar={toolbarConfig}
	style={{ flex: 1, height: 400 }} // Ensure sufficient height
/>
```

#### 2. Button Not Responding to Clicks

**Problem**: Button displays but doesn't respond to clicks

**Solutions**:

- Check if `onToolbarButtonPress` is properly set
- Ensure button's `isEnabled` property is not `false`
- Verify logic in event handler

#### 3. Icons Not Displaying

**Problem**: SF Symbols icons not displaying

**Solutions**:

- Ensure using valid SF Symbols names
- Check if iOS version supports the icon
- Use [SF Symbols app](https://developer.apple.com/sf-symbols/) to verify icon names

### Debugging Tips

```tsx
// Enable debug logging
const handleToolbarButtonPress = (event) => {
	console.log("Toolbar button pressed:", event.nativeEvent);
	// Your handling logic
};

// Validate toolbar configuration
const validateConfig = (config) => {
	console.log("Toolbar config:", JSON.stringify(config, null, 2));
	return config;
};
```

## 🤝 Contributing

We welcome community contributions! Please follow these steps:

### Development Environment Setup

1. **Clone the repository**

```bash
git clone https://github.com/NeitherCupid139/expo-hakka.git
cd expo-hakka
```

2. **Install dependencies**

```bash
bun install
```

3. **Run the example app**

```bash
cd example
bun install
bun ios
```

### Contribution Guidelines

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards

- Use TypeScript
- Follow ESLint configuration
- Add appropriate comments and documentation
- Write test cases

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Expo](https://expo.dev/) - For providing an excellent development platform
- [Apple](https://developer.apple.com/) - SwiftUI and SF Symbols
- All contributors and users

## 📞 Support

If you encounter issues or have suggestions, please:

- Check [Issues](https://github.com/NeitherCupid139/expo-hakka/issues)
- Create a new Issue
- Participate in [Discussions](https://github.com/NeitherCupid139/expo-hakka/discussions)

---

**Made with ❤️ for the React Native community**

For bare React Native projects, you must ensure that you have [installed and configured the `expo` package](https://docs.expo.dev/bare/installing-expo-modules/) before continuing.

### Add the package to your npm dependencies

```
npm install expo-hakka
```

### Configure for Android

### Configure for iOS

Run `npx pod-install` after installing the npm package.

# Contributing

Contributions are very welcome! Please refer to guidelines described in the [contributing guide](https://github.com/expo/expo#contributing).
