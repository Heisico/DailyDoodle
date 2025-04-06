// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473

import SwiftUI

class DoodleStorage: ObservableObject {
    @Published var doodles: [DrawingPath] = []
    @Published var selectedDoodle: DrawingPath?

    func addDoodle(drawing: DrawingPath) {
        doodles.append(drawing)
    }
}
