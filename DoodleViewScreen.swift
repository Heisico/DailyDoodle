import SwiftUI

struct DoodleViewScreen: View {
    var doodle: String

    var body: some View {
        VStack {
            Text(doodle)
                .font(.title)
                .padding()

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 300)
                .cornerRadius(10)
                .padding()

            Text("Your sketch for '\(doodle)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview {
    DoodleViewScreen(doodle: "Tree")
}
