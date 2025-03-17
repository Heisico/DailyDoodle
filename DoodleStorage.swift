import SwiftUI

class DoodleStorage: ObservableObject {
    @Published var doodles: [DrawingPath] = []
    @Published var selectedDoodle: DrawingPath?

    func addDoodle(drawing: DrawingPath) {
        doodles.append(drawing)
    }
}
