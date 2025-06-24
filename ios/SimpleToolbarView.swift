import SwiftUI

// MARK: - 简化的工具栏视图
// 基于你提供的工具栏代码，创建一个简单易用的 SwiftUI 工具栏视图
struct SimpleToolbarView: View {
    @StateObject var toolbarViewModel: ToolbarViewModel

    var body: some View {
        NavigationView {
            VStack {
                // 主要内容区域
                VStack {
                    Spacer()

                    // 工具栏演示内容
                    VStack(spacing: 20) {
                        Image(systemName: "hammer.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)

                        Text("ExpoHakka Toolbar")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("简化的 SwiftUI 工具栏库")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        if let config = toolbarViewModel.config {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("当前配置:")
                                    .font(.headline)

                                if let title = config.title {
                                    Text("标题: \(title)")
                                }

                                if let leading = config.leading, !leading.isEmpty {
                                    Text("左侧按钮: \(leading.count) 个")
                                }

                                if let trailing = config.trailing, !trailing.isEmpty {
                                    Text("右侧按钮: \(trailing.count) 个")
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle(getNavigationTitle())
            .navigationBarTitleDisplayMode(toolbarViewModel.config?.navBarStyle ?? .automatic)
            .navigationBarHidden(toolbarViewModel.config?.hideTitle == true)
            .toolbar {
                // 左侧工具栏按钮
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if let config = toolbarViewModel.config,
                       let leadingButtons = config.leading {
                        ForEach(leadingButtons, id: \.id) { button in
                            toolbarButtonView(button: button, placement: "leading")
                        }
                    }
                }

                // 右侧工具栏按钮
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if let config = toolbarViewModel.config,
                       let trailingButtons = config.trailing {
                        ForEach(trailingButtons, id: \.id) { button in
                            toolbarButtonView(button: button, placement: "trailing")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    


    // MARK: - Helper Methods

    private func getNavigationTitle() -> String {
        if toolbarViewModel.config?.hideTitle == true {
            return ""
        }
        return toolbarViewModel.config?.title ?? "ExpoHakka"
    }

    // MARK: - 简化的工具栏按钮视图
    @ViewBuilder
    private func toolbarButtonView(button: ToolbarButtonModel, placement: String) -> some View {
        Button {
            toolbarViewModel.handleButtonPress(buttonId: button.id, placement: placement)
        } label: {
            Label(button.title, systemImage: button.systemImage)
        }
        .disabled(!toolbarViewModel.isButtonEnabled(button))
        .accessibilityLabel(toolbarViewModel.getAccessibilityLabel(for: button))
    }
}

// MARK: - Preview Provider
#if DEBUG
struct SimpleToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        let toolbarViewModel = ToolbarViewModel()

        // 设置简化的示例配置
        let sampleConfig = """
        {
            "title": "简化工具栏示例",
            "leading": [
                {
                    "id": "profile",
                    "type": "button",
                    "title": "个人资料",
                    "systemImage": "person.crop.circle.fill",
                    "isEnabled": true
                }
            ],
            "trailing": [
                {
                    "id": "add",
                    "type": "button",
                    "title": "添加",
                    "systemImage": "plus",
                    "isEnabled": true
                },
                {
                    "id": "search",
                    "type": "button",
                    "title": "搜索",
                    "systemImage": "magnifyingglass",
                    "isEnabled": true
                },
                {
                    "id": "more",
                    "type": "button",
                    "title": "更多",
                    "systemImage": "ellipsis.circle",
                    "isEnabled": true
                }
            ]
        }
        """

        toolbarViewModel.updateConfig(from: sampleConfig)

        return SimpleToolbarView(toolbarViewModel: toolbarViewModel)
    }
}
#endif
