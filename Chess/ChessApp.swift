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
    @StateObject var chessModel: ChessModel = ChessModel()
    var body: some Scene {
        WindowGroup("Chess Games", id: "ChessListView") {
            ChessListView()
                .environmentObject(chessModel)
        }
        
        WindowGroup("Chess Player", id: "ChessPlayerView", for: BoardModel.self) { $board in
                ChessPlayerView(chessModel: chessModel)
        }
    }
}

