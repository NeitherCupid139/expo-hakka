import ExpoModulesCore

// MARK: - ExpoHakka Module Definition
// Expo module focused on SwiftUI Toolbar functionality
public class ExpoHakkaModule: Module {
  public func definition() -> ModuleDefinition {
    // Module name
    Name("ExpoHakka")

    // Module constants
    Constants([
      "version": "1.0.0",
      "supportedPlatforms": ["ios"]
    ])

    // Synchronous function
    Function("hello") {
      return "ExpoHakka SwiftUI Toolbar Library 👋"
    }

    // View definition
    View(ExpoHakkaView.self) {
      // Event definition
      Events("onToolbarButtonPress")

      // Toolbar configuration property
      Prop("toolbar") { (view: ExpoHakkaView, prop: String?) in
        DispatchQueue.main.async {
          view.updateToolbar(prop)
        }
      }
    }
  }
}
