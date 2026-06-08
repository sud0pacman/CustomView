//
//  CustomViewApp.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

@main
struct CustomViewApp: App {
    @State private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
    }
}
