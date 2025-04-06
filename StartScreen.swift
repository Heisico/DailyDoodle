// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473
import SwiftUI

struct StartScreen: View {
    @State private var word: String = "Press 'Get a Word'"
    @State private var navigateToDrawing = false
    let words = ["Tree", "Sun", "House", "Dog", "Car", "Star", "Balloon", "Fish", "Phone", "Clock"]

    var body: some View {
        VStack {
            Spacer()

            // Display the randomly chosen word with a dark color for visibility
            Text(word)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black) // Set text color to black to ensure visibility on a light background

            // Get a Word button
            Button(action: {
                word = words.randomElement() ?? "Unknown"
            }) {
                Text("Get a Word")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing)) // Gradient button background
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 10) // Adding shadow for depth
                    .padding(.horizontal, 40)
            }
            
            // Start Drawing button
            Button(action: {
                navigateToDrawing = true
            }) {
                Text("Start Drawing")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing)) // Gradient background
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 10) // Shadow for depth
                    .padding(.horizontal, 40)
            }
            .background(
                NavigationLink("", destination: DrawingScreen(word: word), isActive: $navigateToDrawing)
                    .hidden()
            )
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.pink.opacity(0.3)]), startPoint: .top, endPoint: .bottom)) // Gradient background for the entire screen
        .edgesIgnoringSafeArea(.all) // Ensure the background spans across the entire screen
    }
}

#Preview {
    StartScreen()
}
