//
//  Card.swift
//  moreTech
//
//  Created by Vlad on 09.10.2021.
//

import SwiftUI


struct CardData {
    var titleText : String?
    var titleIconName : String?
    var mainText : String?
    var subtitleText : String?
    var additionalTextBlocks : [String]?
    var leftAction : CardActionData?
    var rightAction : CardActionData?
}

struct CardActionData {
    var title : String?
    var iconName : String?
}

struct CardView: View {
    
    @State private var translation: CGSize = .zero
    
    var body: some View {
        
        GeometryReader { geometry in
                   
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title)
                    .bold()
                
                Text("SomeText")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                HStack(alignment: .center, spacing: nil, content: {
                    Text("Left")
                    Spacer()
                    Text("Right")
                })
            }
            // Add padding, corner radius and shadow with blur radius
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10).shadow(radius: 5)
            .offset(x: self.translation.width, y: 0)
            .gesture(
                // 3
                DragGesture()
                    // 4
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        self.translation = .zero
                    }
            )
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
        }
    }
}
