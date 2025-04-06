// Daniel John D. Fajardo III 101424929
// Milan Mislov 101409473
import SwiftUI

struct ContentView: View {
    var body: some View {
        IntroScreen()
    }
}

#Preview {
    ContentView().environmentObject(DoodleStorage())
}
