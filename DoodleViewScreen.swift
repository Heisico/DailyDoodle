import SwiftUI

struct DoodleViewScreen: View {
    @EnvironmentObject var doodleStorage: DoodleStorage

    var body: some View {
        VStack {
            Text("Your Doodle")
                .font(.title)
                .padding()

            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .border(Color.black, width: 2)

                if let doodle = doodleStorage.selectedDoodle {
                    Canvas { context, size in
                        for path in doodle.paths {
                            context.stroke(path, with: .color(.black), lineWidth: 3)
                        }
                    }
                    .frame(height: 300)
                }
            }
            
            Button("Back to Gallery") {
                doodleStorage.selectedDoodle = nil
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    DoodleViewScreen().environmentObject(DoodleStorage())
}
