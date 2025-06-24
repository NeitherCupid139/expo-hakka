import React from "react";
import ExpoHakka, { ExpoHakkaView, Button, createToolbar } from "expo-hakka";
import { Alert, SafeAreaView, ScrollView, Text, View } from "react-native";

export default function App() {
	// Basic toolbar configuration example
	const basicToolbarConfig = createToolbar({
		center: "Hakka Demo",
		leadingButtons: [
			Button("profile", "Profile", "person.crop.circle.fill", () =>
				Alert.alert("Profile", "Open Profile")
			),
		],
		trailingButtons: [
			Button("add", "Add", "plus", () =>
				Alert.alert("Add Button", "Add New Item")
			),
			Button("search", "Search", "magnifyingglass", () =>
				Alert.alert("Search", "Open Search Function")
			),
			Button("more", "More", "ellipsis.circle", () =>
				Alert.alert("More Options", "Open More Options")
			),
		],
	});

	// Custom toolbar configuration example
	const customToolbarConfig = createToolbar({
		center: "Custom Toolbar",
		leadingButtons: [
			Button("back", "Back", "chevron.left", () =>
				Alert.alert("Back", "Go Back to Previous Page")
			),
		],
		trailingButtons: [
			Button("save", "Save", "checkmark", () =>
				Alert.alert("Save", "Save Current Content")
			),
			Button("share", "Share", "square.and.arrow.up", () =>
				Alert.alert("Share", "Share Content")
			),
			Button("settings", "Settings", "gear", () =>
				Alert.alert("Settings", "Open Settings")
			),
		],
	});

	// Toolbar with custom center component
	const toolbarWithCustomCenter = createToolbar({
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

	const handleToolbarButtonPress = (event: any) => {
		const { buttonId, placement } = event.nativeEvent;
		const message = `Button ID: ${buttonId}\nPlacement: ${placement}`;
		Alert.alert("Toolbar Button Pressed", message);
	};

	return (
		<SafeAreaView style={styles.container}>
			<ScrollView style={styles.container}>
				<Text style={styles.header}>ExpoHakka Toolbar Demo</Text>
				<Group name="Module Information">
					<Text>{ExpoHakka.hello()}</Text>
				</Group>
				<Group name="Basic Toolbar Demo">
					<Text style={styles.description}>
						Basic toolbar with title and common buttons using
						createSimpleToolbar
					</Text>
					<ExpoHakkaView
						toolbar={basicToolbarConfig}
						onToolbarButtonPress={handleToolbarButtonPress}
						style={styles.toolbarView}
					/>
				</Group>
				<Group name="Custom Toolbar Demo">
					<Text style={styles.description}>
						Custom toolbar manually built using createSimpleToolbar and
						createToolbarButton
					</Text>
					<ExpoHakkaView
						toolbar={customToolbarConfig}
						onToolbarButtonPress={handleToolbarButtonPress}
						style={styles.toolbarView}
					/>
				</Group>
				<Group name="Custom Center Component Demo">
					<Text style={styles.description}>
						Toolbar with custom React component in center area
					</Text>
					<ExpoHakkaView
						toolbar={toolbarWithCustomCenter}
						onToolbarButtonPress={handleToolbarButtonPress}
						style={styles.toolbarView}
					/>
				</Group>
				<Group name="No Toolbar View">
					<Text style={styles.description}>
						Default view displayed when no toolbar is configured
					</Text>
					<ExpoHakkaView style={styles.view} />
				</Group>
			</ScrollView>
		</SafeAreaView>
	);
}

function Group(props: { name: string; children: React.ReactNode }) {
	return (
		<View style={styles.group}>
			<Text style={styles.groupHeader}>{props.name}</Text>
			{props.children}
		</View>
	);
}

const styles = {
	header: {
		fontSize: 30,
		margin: 20,
		fontWeight: "bold" as const,
		textAlign: "center" as const,
	},
	description: {
		fontSize: 14,
		color: "#666",
		marginBottom: 15,
		lineHeight: 20,
	},
	groupHeader: {
		fontSize: 20,
		marginBottom: 20,
		fontWeight: "600" as const,
	},
	group: {
		margin: 20,
		backgroundColor: "#fff",
		borderRadius: 10,
		padding: 20,
		shadowColor: "#000",
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.1,
		shadowRadius: 4,
		elevation: 3,
	},
	container: {
		flex: 1,
		backgroundColor: "#f5f5f5",
	},
	view: {
		flex: 1,
		height: 200,
		borderRadius: 8,
		overflow: "hidden" as const,
	},
	toolbarView: {
		flex: 1,
		height: 400,
		borderRadius: 8,
		overflow: "hidden" as const,
	},
	customCenter: {
		backgroundColor: "rgba(0, 122, 255, 0.1)",
		paddingHorizontal: 16,
		paddingVertical: 4,
		borderRadius: 12,
	},
	customCenterText: {
		fontSize: 16,
		fontWeight: "600" as const,
		color: "#007AFF",
	},
};
