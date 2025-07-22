import SwiftUI

struct ContentView: View {
    let halloweenSet: Array<String> = ["👻", "😈", "🎃", "🕷️", "☠️", "🕸️", "👹", "🍭", "🍫"]
    let summerSet: Array<String> = ["🏖️", "🌞", "🍉", "🏄‍♀️", "🌊", "🍦", "🏝️", "🌴", "🩴"]
    let christmasSet: Array<String> = ["🎄", "🎅", "❄️", "⛄", "🎁", "🧦", "🍪", "🍫", "🕯️"]

    @State private var currentThemeIndex: Int = 0
    @State private var cardCount: Int = 4
    @State private var shuffledEmojis: Array<String> = []
    
    let themeCardCounts = [5, 4, 6]
    
    /** the current set of emojis */
    var currentEmojis: Array<String> {
        let themes = [halloweenSet, summerSet, christmasSet]
        return themes[currentThemeIndex]
    }
    
    init() {
        _shuffledEmojis = State(initialValue: halloweenSet.shuffled())
        _cardCount = State(initialValue: themeCardCounts[0])
    }
    
    /** all of the content on the screen */
    var body: some View {
        VStack{
            /**
             Task 1: Add a title “Memorize!” to the top of the screen. It’s a title, so it should be in a large
                font and bold.
             */
            Text("Memorize")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            /**
             Task 2: Add three buttons below the title, each representing a theme. The themes are Halloween
                Summer, and Christmas.
             */
            themeButtons
            ScrollView {
                cards
            }
        }
        .padding()
    }
    
    var themeButtons: some View {
        HStack {
            themeButton(name: "Halloween", index: 0, symbol: "moon.stars.fill", color: .orange)
            themeButton(name: "Summer", index: 1, symbol: "sun.max.fill", color: .blue)
            themeButton(name: "Christmas", index: 2, symbol: "snowflake", color: .red)
        }
        .padding(.bottom)
    }
    
    func themeButton(name: String, index: Int, symbol: String, color: Color) -> some View {
        Button(action: {
            currentThemeIndex = index
            cardCount = themeCardCounts[index]
            shuffledEmojis = currentEmojis.shuffled()
            
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .font(.title)
                Text(name)
                    .font(.caption)
            }
            .foregroundColor(currentThemeIndex == index ? color : .gray)
        })
        .padding(.horizontal)
    }
    
    var cardCountModifierButtons: some View {
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
        .font(.title)
    }
    
    
    func cardCountModifierButton(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
                .foregroundColor(.black)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > currentEmojis.count)
    }
    
    var cardAdder: some View {
        /** adding cards button */
        return cardCountModifierButton(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    
    var cardRemover: some View {
        /** removing card button */
        return cardCountModifierButton(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    
    var cards: some View {
        let emojisToShow = shuffledEmojis.isEmpty ? currentEmojis.shuffled() : shuffledEmojis
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            ForEach(0..<min(cardCount, emojisToShow.count), id: \.self) { index in
                ForEach(0..<2, id: \.self) { _ in
                    CardView(content: emojisToShow[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }.foregroundColor(currentThemeIndex == 0 ? .orange : (currentThemeIndex == 1 ? .blue : .red))
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
