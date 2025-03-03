import SwiftUI

struct GalleryScreen: View {
    var doodles: [String]

    var body: some View {
        VStack {
            Text("Gallery")
                .font(.largeTitle)
                .padding()

            List(doodles, id: \.self) { doodle in
                NavigationLink(destination: DoodleViewScreen(doodle: doodle)) {
                    Text(doodle)
                }
            }
        }
    }
}

#Preview {
    GalleryScreen(doodles: ["Tree", "Sun"])
}

