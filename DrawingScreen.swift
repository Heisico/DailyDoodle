import SwiftUI

struct DrawingScreen: View {
    let word: String
    @State private var navigateToGallery = false
    @State private var doodles: [String] = []
    
    var body: some View {
        VStack {
            Text("Draw: \(word)")
                .font(.title)
                .padding()
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
                // Here, you will later integrate actual drawing functionality
            
            HStack {
                Button("Clear") {
                    // Clear Drawing (To be implemented)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Save") {
                    doodles.append(word)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                navigateToGallery = true
            }) {
                Text("Go to Gallery")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .background(
                NavigationLink("", destination: GalleryScreen(doodles: doodles), isActive: $navigateToGallery)
                    .hidden()
            )
        }
    }
}

#Preview {
    DrawingScreen(word: "Example")
}

