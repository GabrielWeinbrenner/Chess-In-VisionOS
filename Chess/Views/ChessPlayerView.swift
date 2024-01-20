//
//  ContentView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

struct ChessPlayerView: View {
    @Environment(\.openWindow) private var openWindow
    @StateObject var chessModel: ChessModel
    var body: some View {
        let currentBoardModel = chessModel.getCurrentBoardModel()
        VStack {
            if let boardModel = currentBoardModel {
                BoardView(boardModel: boardModel, height: 60, width: 60)
            } else {
                Text("Insert Board")
            }
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
