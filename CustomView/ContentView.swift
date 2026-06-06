//
//  ContentView.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(Game.self) var game
    
    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
    ]
    
    @State private var uiID: UUID = UUID()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                LazyVGrid(columns: threeColumnGrid, alignment: .center) {
                    ForEach(game.directions.indices, id: \.self) { index in
                        let arrow = game.directions[index]
                        
                        // Calculate the offsets based on direction and active state
                        let goX: CGFloat = {
                            guard arrow.active else { return 0 }
                            switch arrow.direction {
                            case .left:  return -geo.size.width
                            case .right: return geo.size.width
                            default:     return 0
                            }
                        }()
                        
                        let goY: CGFloat = {
                            guard arrow.active else { return 0 }
                            switch arrow.direction {
                            case .up:    return -geo.size.height
                            case .down:  return geo.size.height
                            default:     return 0
                            }
                        }()
                        
                        let row = index / 3
                        let col = index % 3
                        
                        FlyAwayItem(imageName: arrow.direction.image, goX: goX, goY: goY,)
                    }
                }
                .id(uiID)
                
                Text("\(game.directions.count)")
                
                Button("Reload") {
                    uiID = UUID()
                    game.collectRandomArrow(for: 3)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}


struct FlyAwayItem: View {
    let imageName: String
    let goX: CGFloat
    let goY: CGFloat
    
    @State private var itemOffset: CGSize = .zero
    @State private var isFlewOut: Bool = false
    
    var body: some View {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(.red)
            .offset(itemOffset)
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: itemOffset)
            .opacity(isFlewOut ? 0 : 1) // Ekrandan chiqib ketgach butkul ko'rinmas bo'ladi
            .animation(.easeInOut, value: isFlewOut)
            .onTapGesture {
                itemOffset = CGSize(width: goX, height: goY)
                isFlewOut = true
            }
            .overlay {
                if !isFlewOut {
                    HStack {
                        Image(systemName: imageName)
                        
                        Text("goX: \(goX), goY: \(goY)")
                            .font(.caption2)
                    }
                }
            }
    }
}

#Preview {
    ContentView()
        .environment(Game())
}
