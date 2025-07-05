import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: false)
            CardView()
            CardView()
            CardView(isFaceUp: false)
        }
        .foregroundColor(.orange)
        .padding()
    }
    
}


struct CardView: View {
    
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻")
                    .font(.largeTitle)
            }else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle() // changes the bool value to it's contrary (e.g if it's true, it changes to false)
        }
    }
}

#Preview {
    ContentView()
}
