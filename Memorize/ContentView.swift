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
    
    @State var isFaceUp = true /** temporary state */
    
    var body: some View {
        ZStack(alignment: .center){ /** trailing closure syntax */
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
            /** This function, can take up to two arguments
                    
                    count:
                    perform:
                        
                    In this case, we're performing an action (changing the color)
             */
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
