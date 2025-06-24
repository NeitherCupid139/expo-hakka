import { ToolbarConfig, ToolbarButton } from "../ExpoHakka.types";
import type React from "react";

// =============================================================================
// HELPER FUNCTIONS - Simplified toolbar helper functions
// =============================================================================

/**
 * Create toolbar button
 *
 * @param id Button unique identifier
 * @param title Button title (for accessibility)
 * @param systemImage SF Symbols icon name
 * @param onPress Click event handler function
 * @param options Optional configuration
 * @returns Toolbar button configuration
 *
 * @example
 * ```tsx
 * const addButton = Button(
 *   "add",
 *   "Add",
 *   "plus",
 *   () => console.log("Add button clicked")
 * );
 * ```
 */
export function Button(
	id: string,
	title: string,
	systemImage: string,
	onPress: () => void,
	options?: { isEnabled?: boolean }
): ToolbarButton {
	return {
		id,
		title,
		systemImage,
		onPress,
		isEnabled: options?.isEnabled ?? true,
	};
}

/**
 * Create universal toolbar configuration
 *
 * @param config Toolbar configuration options
 * @returns Complete toolbar configuration
 *
 * @example
 * ```tsx
 * // Simple title
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
 * // Custom center component
 * const toolbarWithCustomCenter = createToolbar({
 *   center: <CustomSearchBar />,
 *   leadingButtons: [...],
 *   trailingButtons: [...]
 * });
 * ```
 */
export function createToolbar(config: {
	center?: React.ReactNode;
	leadingButtons?: ToolbarButton[];
	trailingButtons?: ToolbarButton[];
}): ToolbarConfig {
	return {
		center: config.center,
		leadingButtons: config.leadingButtons || [],
		trailingButtons: config.trailingButtons || [],
	};
}
