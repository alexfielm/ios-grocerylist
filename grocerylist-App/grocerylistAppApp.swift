import SwiftUI
import SwiftData

@main
struct grocerylistAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Grocery.self)
        }
    }
}
