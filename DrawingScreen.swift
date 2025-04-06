
// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473
import SwiftUI

struct DrawingScreen: View {
    let word: String
    @EnvironmentObject var doodleStorage: DoodleStorage
    @State private var drawing = DrawingPath() // Stores user’s drawing
    @State private var navigateToGallery = False
    @State private var timerRunning = True
    @State private var timeLeft = 60
    @State private var showSaveButton = False

    var body: some View {
        VStack {
            // Title with gradient text
            Text("Draw: \(word)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                .padding()

            // Sketchpad where users can draw
            Canvas { context, size in
                for path in drawing.paths {
                    context.stroke(path, with: .color(.black), lineWidth: 3)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 300) // Ensure the canvas takes up the full width and height
            .border(Color.black, width: 2)
            .cornerRadius(15)
            .shadow(color: .black, radius: 5, x: 0, y: 5) // Shadow for the canvas
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        drawing.addPoint(value.location)
                    }
                    .onEnded { _ in
                        drawing.endPath()
                    }
            )

            // Timer with gradient text
            Text("Time left: \(timeLeft)s")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing)) // Gradient timer text
                .padding()

            if showSaveButton {
                // Save button with gradient background and shadow
                Button("Save Doodle") {
                    doodleStorage.addDoodle(drawing: drawing)
                    navigateToGallery = True
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing)) // Gradient button background
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 10) // Shadow for depth
            }

            // Clear button with red gradient and shadow
            Button("Clear") {
                drawing.clear()
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing)) // Gradient button background
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 10) // Shadow for depth

            // Navigation link to gallery
            NavigationLink(destination: GalleryScreen(), isActive: $navigateToGallery) {
                EmptyView()
            }
        }
        .onAppear {
            startTimer()
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: True) { timer in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                timer.invalidate()
                showSaveButton = True
            }
        }
    }
}

// Stores drawing paths
class DrawingPath: ObservableObject, Identifiable {
    let id = UUID()
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
