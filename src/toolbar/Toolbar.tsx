import { requireNativeView } from "expo";
import * as React from "react";
import { ViewProps, View, StyleSheet } from "react-native";

import { ExpoHakkaViewProps, ToolbarConfig } from "../ExpoHakka.types";

// =============================================================================
// NATIVE VIEW INTERFACE
// =============================================================================

/**
 * Native view props interface
 * Serializes toolbar object as JSON string to pass to native layer
 */
interface NativeToolbarProps
	extends Omit<ExpoHakkaViewProps, "toolbar">,
		ViewProps {
	toolbar?: string; // Native layer receives serialized JSON string
}

const NativeView: React.ComponentType<NativeToolbarProps> =
	requireNativeView("ExpoHakka");

// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

/**
 * Convert simplified toolbar configuration to native layer format
 */
function convertToNativeToolbarConfig(config: ToolbarConfig) {
	const nativeConfig: any = {
		title: typeof config.center === "string" ? config.center : undefined,
		hideTitle: config.center && typeof config.center !== "string",
		leading: [],
		trailing: [],
	};

	// Process leading buttons
	if (config.leadingButtons && config.leadingButtons.length > 0) {
		config.leadingButtons.forEach((button) => {
			nativeConfig.leading.push({
				id: button.id,
				type: "button",
				title: button.title,
				systemImage: button.systemImage,
				isEnabled: button.isEnabled,
			});
		});
	}

	// Process trailing buttons
	if (config.trailingButtons && config.trailingButtons.length > 0) {
		config.trailingButtons.forEach((button) => {
			nativeConfig.trailing.push({
				id: button.id,
				type: "button",
				title: button.title,
				systemImage: button.systemImage,
				isEnabled: button.isEnabled,
			});
		});
	}

	return nativeConfig;
}

/**
 * Serialize toolbar configuration to JSON string
 */
function serializeToolbarConfig(config?: ToolbarConfig): string | undefined {
	if (!config) return undefined;

	try {
		const nativeConfig = convertToNativeToolbarConfig(config);
		return JSON.stringify(nativeConfig);
	} catch (error) {
		console.error("ExpoHakka: Failed to serialize toolbar config:", error);
		return undefined;
	}
}

// =============================================================================
// MAIN COMPONENT
// =============================================================================

/**
 * SwiftUI Toolbar Component
 *
 * Provides native iOS SwiftUI Toolbar functionality for React Native
 * Universal API supporting flexible left, center, and right area configuration
 *
 * @example Basic toolbar with title
 * ```tsx
 * import { Toolbar, createToolbar, Button } from 'expo-hakka';
 *
 * const toolbar = createToolbar({
 *   center: "My App",
 *   leadingButtons: [
 *     Button("profile", "Profile", "person.crop.circle.fill", () => {})
 *   ],
 *   trailingButtons: [
 *     Button("add", "Add", "plus", () => {}),
 *     Button("search", "Search", "magnifyingglass", () => {})
 *   ]
 * });
 *
 * <Toolbar toolbar={toolbar} style={{ flex: 1 }} />
 * ```
 *
 * @example Custom center component
 * ```tsx
 * const toolbar = createToolbar({
 *   center: <CustomSearchBar />,
 *   leadingButtons: [...],
 *   trailingButtons: [...]
 * });
 *
 * <Toolbar
 *   toolbar={toolbar}
 *   style={{ flex: 1 }}
 * />
 * ```
 */
export default function Toolbar(props: ExpoHakkaViewProps) {
	const { toolbar, onToolbarButtonPress, children, ...restProps } = props;

	// Store action callback references
	const actionsRef = React.useRef<Map<string, () => void>>(new Map());

	// Handle toolbar configuration serialization and action storage
	const serializedToolbar = React.useMemo(() => {
		if (!toolbar) return undefined;

		// Clear previous actions
		actionsRef.current.clear();

		// Store leading button actions
		if (toolbar.leadingButtons) {
			toolbar.leadingButtons.forEach((button) => {
				actionsRef.current.set(button.id, button.onPress);
			});
		}

		// Store trailing button actions
		if (toolbar.trailingButtons) {
			toolbar.trailingButtons.forEach((button) => {
				actionsRef.current.set(button.id, button.onPress);
			});
		}

		return serializeToolbarConfig(toolbar);
	}, [toolbar]);

	// Handle native events
	const handleToolbarButtonPress = React.useCallback(
		(event: any) => {
			const { buttonId, placement } = event.nativeEvent;

			// Execute corresponding action
			const action = actionsRef.current.get(buttonId);
			if (action) {
				action();
			}

			// Call user-provided event handler
			if (onToolbarButtonPress) {
				onToolbarButtonPress({
					nativeEvent: {
						buttonId,
						placement,
					},
				});
			}
		},
		[onToolbarButtonPress]
	);

	// Build props to pass to native view
	const nativeProps: NativeToolbarProps = {
		...restProps,
		toolbar: serializedToolbar,
		onToolbarButtonPress: handleToolbarButtonPress,
	};

	// Check if there's a custom center component
	const hasCustomCenter = toolbar?.center && typeof toolbar.center !== "string";

	return (
		<View style={{ flex: 1 }}>
			<NativeView {...nativeProps}>{children}</NativeView>
			{hasCustomCenter && (
				<View style={styles.centerOverlay}>{toolbar.center}</View>
			)}
		</View>
	);
}

// =============================================================================
// STYLES
// =============================================================================

const styles = StyleSheet.create({
	centerOverlay: {
		position: "absolute",
		top: 0,
		left: 0,
		right: 0,
		height: 44, // Standard iOS navigation bar height
		justifyContent: "center",
		alignItems: "center",
		pointerEvents: "none", // Allow touches to pass through to native toolbar
	},
});
