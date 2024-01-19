//
//  ContentView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

struct ChessPlayerView: View {
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var chessModel: ChessModel
    var body: some View {
        var currentBoardModel = chessModel.getCurrentBoardModel()
        VStack {
            Text("Welcome to Chess")
            if let boardModel = currentBoardModel {
                BoardView(boardModel: boardModel)
            } else {
                Text("Insert Board")
            }
//                VStack {
//                    Rectangle()
//                        .frame(width: 100, height: 100)
//                    Text("Insert Board")
//                }
//                .dropDestination(for: BoardModel.self) { boardModels, location in
//
//                    for board in boardModels {
//                        print(board.toString())
//                        self.boardModel = board
//                    }
//                    return true
//                }
        }
        .dropDestination(for: BoardModel.self) { boardModels, location in
            for boardModel in boardModels {
                chessModel.setCurrentBoardModel(boardModel: boardModel)
            }
            return true
        }

    }
}
