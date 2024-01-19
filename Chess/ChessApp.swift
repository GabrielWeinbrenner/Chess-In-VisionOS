//
//  ChessApp.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI
//import RealityKit
//import RealityKitContent
@main
struct ChessApp: App {
    @EnvironmentObject var chessModel: ChessModel
    var body: some Scene {
        WindowGroup("Chess Games", id: "ChessListView") {
            ChessListView()
                .environmentObject(chessModel)
        }
        
        WindowGroup("Chess Player", id: "ChessPlayerView", for: BoardModel.self) { $board in
            if let id = board?.id, let boardModel = chessModel.getBoardModels(id: id) {
                ChessPlayerView()
                    .environmentObject(chessModel)
            } else {
                ChessPlayerView()
                    .environmentObject(chessModel.getRandomBoard())
            }
        }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

