import SwiftUI

struct GalleryScreen: View {
    @EnvironmentObject var doodleStorage: DoodleStorage

    var body: some View {
        VStack {
            Text("Gallery")
                .font(.largeTitle)
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
                                ZStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 150, height: 150)
                                        .border(Color.black, width: 2)
                                    
                                    Canvas { context, size in
                                        for path in doodleStorage.doodles[index].paths {
                                            context.stroke(path, with: .color(.black), lineWidth: 3)
                                        }
                                    }
                                    .frame(width: 150, height: 150)
                                }

                                Button("View Doodle") {
                                    doodleStorage.selectedDoodle = doodleStorage.doodles[index]
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 5)

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
    }
}

#Preview {
    GalleryScreen().environmentObject(DoodleStorage())
}
