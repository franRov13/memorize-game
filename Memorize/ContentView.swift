import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "😈", "🎃", "🕷️", "☠️", "🕸️", "👹", "🍭", "🍫"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            cards
            cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View {
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardAdder: some View {
        /** adding cards button */
        Button(action: {
            if (cardCount < emojis.count) { cardCount += 1}
        }, label: {
            Image(systemName: "rectangle.stack.badge.plus")
        })
        .foregroundColor(.blue)
    }
    
    var cardRemover: some View {
        /** removing card button */
        Button(action: {
            if (cardCount > 1) { cardCount -= 1}
        }, label: {
            Image(systemName: "rectangle.stack.badge.minus")
        })
        .foregroundColor(.red)
    }
    
    
    var cards: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }.foregroundColor(.orange)
    }
}



struct CardView: View {
    
    /** arguments*/
    let content: String
    @State var isFaceUp = true /** temporary state */
    

    /** view body*/
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
