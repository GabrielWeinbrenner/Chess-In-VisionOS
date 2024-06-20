//
//  ContentView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI
import RealityKit

struct ChessPlayerView: View {
    @Environment(\.openWindow) private var openWindow
    var chessModel: ChessModel
    var currentBoardModel: BoardModel
    init(chessModel: ChessModel) {
        self.chessModel = chessModel
        let boardModel = chessModel.currentBoardModel
        currentBoardModel = boardModel
    }
    var body: some View {
        VStack {
            BoardView(boardModel: currentBoardModel, height: 60, width: 60)
        }
        .dropDestination(for: BoardModel.self) { boardModels, location in
            do {
                if let boardModel = boardModels.first {
                    let address = Unmanaged.passUnretained(boardModel).toOpaque()
                    print("DRAG \(address) \(boardModel.id) \(location)")
                    try chessModel.setCurrentBoardModel(id: boardModel.id)
                    return true
                }
                return false
            } catch {
                return false
            }
            
        }

    }
    
}
