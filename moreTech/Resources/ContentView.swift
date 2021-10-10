//
//  ContentView.swift
//  moreTech
//
//  Created by Vlad on 09.10.2021.
//

import SwiftUI

struct Card: Hashable, CustomStringConvertible {
    var id: Int
    var name : String
    var description: String {
        return "\(name), id: \(id)"
    }
}

struct CardView: View {
    @State private var translation: CGSize = .zero
    
    var card: Card
    private var onRemove: (_ card: Card) -> Void
    
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    
    init(card: Card, onRemove: @escaping (_ card: Card) -> Void) {
        self.card = card
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image(card.name)
                .shadow(radius: 15)
                .offset(x: self.translation.width, y: 0)
                .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                        }.onEnded { value in
                            if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                                self.onRemove(self.card)
                            } else {
                                self.translation = .zero
                            }
                        }
                )
        }
    }
}

struct MyRectView: View {
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .frame(width: 200, height: 200)
    }
}

enum screenStating : String {
    case error = "error"
    case help = "help"
    case stonks = "stonks"
    case low = "low"
    case settings = "SettingsScreen"
    case menu = "Additions"
    case none = "defaultIcon"
}

struct ContentView: View {
    
    @State var cards : [Card] = [
        Card(id: 0, name: "Card1"),
        Card(id: 1, name: "Card2"),
        Card(id: 2, name: "Card3"),
        Card(id: 3, name: "Card4"),
        Card(id: 4, name: "Card5"),
        Card(id: 5, name: "Card6"),
        Card(id: 6, name: "Card7"),
        Card(id: 7, name: "Card8"),
        Card(id: 8, name: "Card9")
    ]
    private let constants = Constants.shared
    @State private var translation: CGSize = .zero
    
    private var maxID: Int {
        return self.cards.map { $0.id }.max() ?? 0
    }
    
    @State private var screen : screenStating = .none
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                
                if self.screen == .settings {
                    Button(action: {
                        self.screen = .none
                    }) {
                        Image(self.screen.rawValue)
                    }
                    .transition(.slide)
                    .edgesIgnoringSafeArea(.all)
                } else {
                    
                    VStack(alignment: .center) {
                        VStack {
                            HStack(alignment: .top) {
                                Button {
                                    self.screen = .settings
                                } label: {
                                    Image(constants.settingsImageName)
                                }
                                Spacer()
                                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                                    if self.screen == .menu {
                                        Button(action: {
                                            self.screen = .none
                                        }) {
                                            Image(self.screen.rawValue)
                                        }
                                        .transition(.opacity)
                                    } else {
                                        Button {
                                            self.screen = .menu
                                        } label: {
                                            Image(constants.additionalImageName)
                                        }
                                    }
                                }
                            }
                            
                            HStack(alignment: .center) {
                                Text("120.000")
                                    .font(.system(size: 50.0, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                Image(constants.coinsImageName)
                            }
                            
                            HStack(alignment: .top, spacing: nil, content: {
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("+1000₽")
                                        .font(.system(size: 24.0, weight: .bold, design: .default))
                                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.9490196078, blue: 0.6078431373, alpha: 1)))
                                    HStack {
                                        Image(constants.upImageName)
                                        Button("Доходы") {
                                            self.screen = .stonks
                                        }
                                        .font(.system(size: 20.0, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    }
                                    Text("+4000₽")
                                        .font(.system(size: 18.0, weight: .bold, design: .default))
                                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.9490196078, blue: 0.6078431373, alpha: 1)))
                                    
                                }
                                Spacer()
                                Image(constants.borderImageName)
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("8.34%")
                                        .font(.system(size: 24.0, weight: .bold, design: .default))
                                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.9490196078, blue: 0.6078431373, alpha: 1)))
                                    HStack {
                                        Button("Расходы") {
                                            self.screen = .low
                                        }
                                        .font(.system(size: 20.0, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                        Image(constants.downImageName)
                                    }
                                    Text("-3000₽")
                                        .font(.system(size: 18.0, weight: .bold, design: .default))
                                        .foregroundColor(Color(#colorLiteral(red: 0.9843137255, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                                }
                                Spacer()
                            })
                        }
                        
                        Spacer()
                        Spacer()
                        
                        
                        HStack(alignment: .center) {
                            Spacer()
                            VStack {
                                Image(constants.egorksImageName)
                                Text("Егорка")
                                    .font(.system(size: 18.0, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                            }
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                                if [.error,.stonks, .low, .help].contains(self.screen) {
                                    Button(action: {
                                        self.screen = .none
                                    }) {
                                        Image(self.screen.rawValue)
                                    }
                                    .transition(.opacity)
                                    .onAppear(perform: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                            if self.screen != .none { self.screen = .none }
                                        }
                                    })
                                } else {
                                    VStack(alignment: .leading) {
                                        Text("Нужна помощь?")
                                            .font(.system(size: 22.0, weight: .light, design: .default))
                                            .foregroundColor(.white)
                                        Button("Получить подсказку") {
                                            self.screen = .help
                                        }
                                        .font(.system(size: 20.0, weight: .light, design: .default))
                                        .foregroundColor(Color(#colorLiteral(red: 0.9077750428, green: 0.6666666667, blue: 1, alpha: 1)))
                                    }
                                }
                            }
                            Spacer()
                        }
                        
                        Spacer()
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                            ForEach(self.cards, id: \.self) { card in
                                if card.id > self.maxID - 2 {
                                    CardView(card: card, onRemove: { removedUser in
                                        self.cards.removeAll { $0.id == removedUser.id }
                                        if Bool.random() && Bool.random() { self.screen = .error }
                                        else {self.screen = .none}
                                    })
                                    .padding(constants.spacingS)
                                    .animation(.spring())
                                    .offset(x: 0, y: self.getCardOffset(geometry, id: card.id))
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.leading, constants.spacingM)
                    .padding(.trailing, constants.spacingM)
                    .padding(.top, constants.spacingL)
                    .padding(.bottom, constants.spacingM)
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2666666667, green: 0.6666666667, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1333333333, green: 0.3137254902, blue: 0.5803921569, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(cards.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(cards.count - 1 - id) * 10
    }
}
