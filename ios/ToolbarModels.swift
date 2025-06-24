import SwiftUI

// MARK: - Simplified Toolbar Data Models

/**
 * 简化的工具栏按钮模型
 * 只包含基本的按钮属性，移除复杂的样式和菜单支持
 */
struct ToolbarButtonModel: Codable, Identifiable {
    let id: String
    let type: String
    let title: String
    let systemImage: String
    let isEnabled: Bool?
}

/**
 * Title style configuration
 */
struct TitleStyleModel: Codable {
    let fontSize: Double?
    let fontWeight: String?
    let color: String?
}

/**
 * 简化的工具栏配置模型
 * 只支持左右两侧的按钮配置，移除底部栏和复杂的导航栏样式
 */
struct ToolbarConfigModel: Codable {
    let leading: [ToolbarButtonModel]?
    let trailing: [ToolbarButtonModel]?
    let title: String?
    let hideTitle: Bool?
    let titleStyle: TitleStyleModel?

    // 默认使用自动样式
    var navBarStyle: NavigationBarItem.TitleDisplayMode {
        return .automatic
    }
}

// MARK: - Simplified Toolbar View Model

/**
 * 简化的工具栏视图模型
 * 移除复杂的菜单和间距支持，只处理基本的按钮配置
 */
class ToolbarViewModel: ObservableObject {
    @Published var config: ToolbarConfigModel?

    var onButtonPress: ((String, String) -> Void)?

    func updateConfig(from jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else {
            print("ToolbarViewModel: Invalid JSON data")
            return
        }

        do {
            let decoder = JSONDecoder()
            let newConfig = try decoder.decode(ToolbarConfigModel.self, from: data)

            DispatchQueue.main.async {
                self.config = newConfig
            }

            print("ToolbarViewModel: Successfully updated config with title: \(newConfig.title ?? "No title")")
        } catch {
            print("ToolbarViewModel: Failed to decode toolbar config: \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("ToolbarViewModel: JSON content: \(jsonString)")
            }
        }
    }

    func handleButtonPress(buttonId: String, placement: String) {
        print("ToolbarViewModel: Button pressed - ID: \(buttonId), Placement: \(placement)")
        onButtonPress?(buttonId, placement)
    }

    func clearConfig() {
        DispatchQueue.main.async {
            self.config = nil
        }
    }

    // MARK: - Helper Methods

    func isButtonEnabled(_ button: ToolbarButtonModel) -> Bool {
        return button.isEnabled ?? true
    }

    func getAccessibilityLabel(for button: ToolbarButtonModel) -> String {
        return button.title
    }
}
