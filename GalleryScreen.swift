
// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473
import SwiftUI

struct GalleryScreen: View {
    @EnvironmentObject var doodleStorage: DoodleStorage

    var body: some View {
        VStack {
            // Title with gradient text
            Text("Gallery")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                .padding()

            if doodleStorage.doodles.isEmpty {
                Text("No saved doodles yet!")
                    .font(.title3)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(doodleStorage.doodles.indices, id: \.self) { index in
                            VStack {
                                // Doodle container with gradient background and shadow
                                ZStack {
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                        .border(Color.black, width: 2)
                                    
                                    // Canvas to display doodle
                                    Canvas { context, size in
                                        for path in doodleStorage.doodles[index].paths {
                                            context.stroke(path, with: .color(.black), lineWidth: 3)
                                        }
                                    }
                                    .frame(width: 150, height: 150)
                                }

                                // View Doodle button with gradient background
                                Button("View Doodle") {
                                    doodleStorage.selectedDoodle = doodleStorage.doodles[index]
                                }
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .padding(.top, 5)

                                // Navigation link to DoodleViewScreen
                                NavigationLink(destination: DoodleViewScreen(), isActive: Binding(
                                    get: { doodleStorage.selectedDoodle != nil },
                                    set: { _ in doodleStorage.selectedDoodle = nil }
                                )) {
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.1), Color.orange.opacity(0.2)]), startPoint: .top, endPoint: .bottom)) // Background gradient
    }
}

#Preview {
    GalleryScreen().environmentObject(DoodleStorage())
}
