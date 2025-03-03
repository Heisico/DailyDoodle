import SwiftUI

struct StartScreen: View {
    @State private var word: String = "Press 'Get a Word'"
    @State private var navigateToDrawing = false
    
    let words = ["Tree", "Sun", "House", "Dog", "Car", "Star", "Balloon", "Fish", "Phone", "Clock"]

    var body: some View {
        VStack {
            Spacer()
            
            Text(word)
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                word = words.randomElement() ?? "Unknown"
            }) {
                Text("Get a Word")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            
            Button(action: {
                navigateToDrawing = true
            }) {
                Text("Start Drawing")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .background(
                NavigationLink("", destination: DrawingScreen(word: word), isActive: $navigateToDrawing)
                    .hidden()
            )
            
            Spacer()
        }
    }
}

#Preview {
    StartScreen()
}

