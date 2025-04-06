// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473
import SwiftUI

struct IntroScreen: View {
    @State private var navigateToStart = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // Title with gradient text
                Text("Daily Doodle")
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)) // Gradient text style
                    .padding()
                    .shadow(color: .black, radius: 5, x: 0, y: 5) // Shadow for a more artsy look
                
                // Start Drawing Button with gradient and shadow
                Button(action: {
                    navigateToStart = true
                }) {
                    Text("Start Drawing!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing)) // Gradient button background
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 10) // Shadow for depth
                        .padding(.horizontal, 40)
                }
                .background(
                    NavigationLink(destination: StartScreen(), isActive: $navigateToStart) {
                        EmptyView()
                    }
                    .hidden()
                )
                
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.pink.opacity(0.3)]), startPoint: .top, endPoint: .bottom)) // Gradient background for the entire screen
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true) // Hide the navigation bar completely
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Optional: Forces the navigation view style to avoid unexpected layout issues
    }
}

#Preview {
    IntroScreen()
}
