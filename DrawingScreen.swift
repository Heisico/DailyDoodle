import SwiftUI

struct DrawingScreen: View {
    let word: String
    @EnvironmentObject var doodleStorage: DoodleStorage
    @State private var drawing = DrawingPath() // Stores user’s drawing
    @State private var navigateToGallery = false
    @State private var timerRunning = true
    @State private var timeLeft = 60
    @State private var showSaveButton = false

    var body: some View {
        VStack {
            Text("Draw: \(word)")
                .font(.title)
                .padding()

            // Sketchpad where users can draw
            Canvas { context, size in
                for path in drawing.paths {
                    context.stroke(path, with: .color(.black), lineWidth: 3)
                }
            }
            .frame(height: 300)
            .border(Color.black, width: 2)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        drawing.addPoint(value.location)
                    }
                    .onEnded { _ in
                        drawing.endPath()
                    }
            )
            .background(Color.white)

            Text("Time left: \(timeLeft)s")
                .font(.title3)
                .padding()

            if showSaveButton {
                Button("Save Doodle") {
                    doodleStorage.addDoodle(drawing: drawing)
                    navigateToGallery = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Button("Clear") {
                drawing.clear()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            NavigationLink(destination: GalleryScreen(), isActive: $navigateToGallery) {
                EmptyView()
            }
        }
        .onAppear {
            startTimer()
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                timer.invalidate()
                showSaveButton = true
            }
        }
    }
}

// Stores drawing paths
class DrawingPath: ObservableObject {
    @Published var paths: [Path] = []
    private var currentPath = Path()

    func addPoint(_ point: CGPoint) {
        currentPath.addLine(to: point)
        paths.append(currentPath)
    }

    func endPath() {
        currentPath = Path()
    }

    func clear() {
        paths.removeAll()
    }
}

#Preview {
    DrawingScreen(word: "Example").environmentObject(DoodleStorage())
}
