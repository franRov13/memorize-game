import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "😈", "🏋️‍♂️", "🕷️", "🐼"]
    
    var body: some View {
        HStack{
            /** For i in range 0 < 4, display the views*/
        
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}


struct CardView: View {
    
    let content: String
    
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
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
