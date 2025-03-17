import SwiftUI

@main
struct DailyDoodleApp: App {
    @StateObject private var doodleStorage = DoodleStorage()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(doodleStorage) // Inject it here
        }
    }
}
