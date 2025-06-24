import type { StyleProp, ViewStyle } from "react-native";
import type React from "react";

// =============================================================================
// SIMPLE TOOLBAR TYPES - Simplified toolbar type definitions
// =============================================================================

/**
 * Toolbar button configuration
 * Simple button with icon and click event
 */
export interface ToolbarButton {
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

/**
 * Universal toolbar configuration
 * Simple and flexible API for left, center, and right areas
 */
export interface ToolbarConfig {
	/** Center area - can be title string or React component */
	center?: React.ReactNode;

	/** Leading buttons (usually avatar, back button, etc.) */
	leadingButtons?: ToolbarButton[];

	/** Trailing button group (add, search, more, etc.) */
	trailingButtons?: ToolbarButton[];
}

// Keep backward compatibility
export type SimpleToolbarConfig = ToolbarConfig;

// =============================================================================
// EVENTS - Event types
// =============================================================================

/**
 * Toolbar button press event
 */
export interface ToolbarButtonPressEvent {
	nativeEvent: {
		/** ID of the clicked button */
		buttonId: string;
		/** Button placement: 'leading' | 'trailing' */
		placement: string;
	};
}

// =============================================================================
// MAIN COMPONENT PROPS - Main component properties
// =============================================================================

/**
 * ExpoHakka toolbar view component properties
 */
export interface ExpoHakkaViewProps {
	/** Toolbar configuration */
	toolbar?: ToolbarConfig;

	/** Toolbar button press event handler (optional, button's own onPress will be called automatically) */
	onToolbarButtonPress?: (event: ToolbarButtonPressEvent) => void;

	/** View style */
	style?: StyleProp<ViewStyle>;

	/** Child components */
	children?: React.ReactNode;
}
