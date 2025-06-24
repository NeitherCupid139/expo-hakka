import ExpoModulesCore
import SwiftUI
import UIKit

// MARK: - ExpoHakka SwiftUI Toolbar View
// Native view component focused on SwiftUI Toolbar functionality
class ExpoHakkaView: ExpoView {
  // MARK: - Properties

  // SwiftUI content view controller
  private var contentView: UIHostingController<AnyView>?

  // View model
  let toolbarViewModel = ToolbarViewModel()

  // Event dispatcher
  let onToolbarButtonPress = EventDispatcher()

  // State management
  private var hasToolbar = false

  // MARK: - Initialization

  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)

    setupView()
    setupEventHandlers()
    showSwiftUIContent()
  }

  // MARK: - Setup Methods

  private func setupView() {
    clipsToBounds = true
    backgroundColor = UIColor.systemBackground
  }

  private func setupEventHandlers() {
    // Setup toolbar button press event handling
    toolbarViewModel.onButtonPress = { [weak self] (buttonId: String, placement: String) in
      self?.onToolbarButtonPress([
        "buttonId": buttonId,
        "placement": placement
      ])
    }
  }

  // MARK: - SwiftUI Content Management

  private func createSwiftUIContent() -> AnyView {
    if hasToolbar {
      // View with toolbar
      return AnyView(
        SimpleToolbarView(
          toolbarViewModel: self.toolbarViewModel
        )
      )
    } else {
      // Empty view
      return AnyView(
        VStack {
          Spacer()
          Text("ExpoHakka Toolbar")
            .font(.title2)
            .foregroundColor(.secondary)
          Text("Configure toolbar to display content")
            .font(.caption)
            .foregroundColor(.secondary)
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
      )
    }
  }

  private func showSwiftUIContent() {
    updateSwiftUIContent()
  }

  private func updateSwiftUIContent() {
    // Remove old content view
    contentView?.view.removeFromSuperview()
    contentView = nil

    // Create new content view
    let newContentView = UIHostingController(rootView: createSwiftUIContent())
    contentView = newContentView

    // Add to view hierarchy
    addSubview(newContentView.view)
    newContentView.view.translatesAutoresizingMaskIntoConstraints = false

    // Set constraints to fill entire view
    NSLayoutConstraint.activate([
      newContentView.view.topAnchor.constraint(equalTo: topAnchor),
      newContentView.view.leadingAnchor.constraint(equalTo: leadingAnchor),
      newContentView.view.trailingAnchor.constraint(equalTo: trailingAnchor),
      newContentView.view.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  // MARK: - Public Methods

  func updateToolbar(_ configJson: String?) {
    if let configJson = configJson, !configJson.isEmpty {
      hasToolbar = true
      toolbarViewModel.updateConfig(from: configJson)
      print("ExpoHakkaView: Updated toolbar config, hasToolbar: \(hasToolbar)")
    } else {
      hasToolbar = false
      toolbarViewModel.clearConfig()
      print("ExpoHakkaView: Cleared toolbar config")
    }

    // Update SwiftUI content
    updateSwiftUIContent()
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    // Using Auto Layout constraints, no need to manually set frame
  }
}
