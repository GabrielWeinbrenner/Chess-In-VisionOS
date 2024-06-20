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
    @ObservedObject var chessModel: ChessModel = ChessModel()
    var chess3DViewModel: Chess3DViewModel
    init() {
        let model = ChessModel()
        chessModel = model
        boardModel = model.getCurrentBoardModel()
        chess3DViewModel = Chess3DViewModel(boardModel: boardModel )
       
    }
    var body: some Scene {
        WindowGroup("Chess Games", id: "ChessListView") {
            ChessListView()
                .environmentObject(chessModel)
        }
        
        WindowGroup("Chess Player", id: "ChessPlayerView", for: BoardModel.self) { $board in
            ChessPlayerView(chessModel: chessModel)
        }
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(chess3DViewModel: chess3DViewModel)
        }
    }
}

