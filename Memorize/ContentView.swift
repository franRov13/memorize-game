import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "😈", "🎃", "🕷️", "☠️", "🕸️", "👹", "🍭", "🍫"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            Spacer()
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
    
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardAdder: some View {
        /** adding cards button */
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var cardRemover: some View {
        /** removing card button */
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
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
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
