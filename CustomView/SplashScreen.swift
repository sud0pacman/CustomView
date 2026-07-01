//
//  SplashScreen.swift
//  CustomView
//
//  Created by G'aniyev Muhammad on 02/07/26.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    LazyVGrid(columns: [GridItem(.fixed(60)), GridItem(.fixed(60))], alignment: .center, spacing: 10) {
                        FlyAwayItem(color: .orange, goX: 0, goY: -geo.size.height)
                        FlyAwayItem(color: .red, goX: geo.size.width, goY: 0)
                        FlyAwayItem(color: .blue, goX: -geo.size.width, goY: 0)
                        FlyAwayItem(color: .brown, goX: 0, goY: geo.size.height)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(UIColor.systemBackground)) // Adapts to Dark Mode
            .ignoresSafeArea()
            .onAppear {
                // Adjust delay time to sync with your 2.0s item animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct FlyAwayItem: View {
    let color: Color
    let goX: CGFloat
    let goY: CGFloat
    
    @State private var itemOffset: CGSize = .zero
    @State private var isFlewOut: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 50, height: 50)
            .offset(itemOffset)
            .opacity(isFlewOut ? 0 : 1)
            .onTapGesture {
                triggerAnimation()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    triggerAnimation()
                }
            }
    }
    
    private func triggerAnimation() {
        guard !isFlewOut else { return }
        
        withAnimation(.spring(response: 0.7, dampingFraction: 0.9)) {
            itemOffset = CGSize(width: goX, height: goY)
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            isFlewOut = true
        }
    }
}

// Preview
struct FlyAwayAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
