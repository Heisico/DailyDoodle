import SwiftUI

struct IntroScreen: View {
    @State private var navigateToStart = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Daily Doodle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Button(action: {
                    navigateToStart = true
                }) {
                    Text("Start Drawing!")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
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
            .navigationBarHidden(true) // Hides the top-left navigation bar
        }
    }
}

#Preview {
    IntroScreen()
}

