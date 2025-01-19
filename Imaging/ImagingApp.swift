import SwiftUI
import SwiftData

@main
struct ImagingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [UserModel.self])
        }
    }
}
