// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473
import SwiftUI

struct DoodleViewScreen: View {
    @EnvironmentObject var doodleStorage: DoodleStorage
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Your Doodle")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
                .shadow(radius: 10)
                .padding(.bottom, 20)

            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
                    .frame(height: 300)
                    .cornerRadius(15)
                    .shadow(radius: 10)

                if let doodle = doodleStorage.selectedDoodle {
                    Canvas { context, size in
                        for path in doodle.paths {
                            context.stroke(path, with: .color(.black), lineWidth: 3)
                        }
                    }
                    .frame(height: 300)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
            }

            HStack(spacing: 20) {
                Button(action: shareDoodle) {
                    Text("Share")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .scaleEffect(1.05)
                }

                Button(action: deleteDoodle) {
                    Text("Delete")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .scaleEffect(1.05)
                }
            }
            .padding(.horizontal)

            Button("Back to Gallery") {
                doodleStorage.selectedDoodle = nil
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .font(.title2)
            .scaleEffect(1.1)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
        .shadow(radius: 15)
    }

    // MARK: - Actions

    func shareDoodle() {
        guard let doodle = doodleStorage.selectedDoodle else { return }

        // Convert to UIImage
        let renderer = ImageRenderer(content: DoodleCanvasView(doodle: doodle))
        if let image = renderer.uiImage {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)

            // Fix for iPad crash
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                activityVC.popoverPresentationController?.sourceView = rootVC.view
                activityVC.popoverPresentationController?.sourceRect = CGRect(x: rootVC.view.bounds.midX, y: rootVC.view.bounds.midY, width: 0, height: 0)
                activityVC.popoverPresentationController?.permittedArrowDirections = []

                rootVC.present(activityVC, animated: true)
            }
        }
    }

    func deleteDoodle() {
        if let selected = doodleStorage.selectedDoodle,
           let index = doodleStorage.doodles.firstIndex(where: { $0.id == selected.id }) {
            doodleStorage.doodles.remove(at: index)
            doodleStorage.selectedDoodle = nil
            dismiss()
        }
    }
}

// This helper view is used to render the doodle as an image
struct DoodleCanvasView: View {
    var doodle: DrawingPath

    var body: some View {
        Canvas { context, size in
            for path in doodle.paths {
                context.stroke(path, with: .color(.black), lineWidth: 3)
            }
        }
        .frame(width: 300, height: 300)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.purple.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15)
    }
}
