//
//  Board.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

struct BoardView: View {

    var boardModel: BoardModel
    var selectionModel: SelectionModel = SelectionModel()
    
    var body: some View {
        VStack {
            Text("\(boardModel.currentPlayer.toString())'s turn")
            if boardModel.gameFinished {
                Text("____ HAS WON by checkmate")
            }
            VStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { col in
                            if let squareModel = boardModel.board[row][col] {
                                SquareView(squareModel: squareModel, boardModel: boardModel, selectionModel: selectionModel)
                            }
                        }
                    }
                }
            }.padding()
            
        }
        .onDisappear() {
            print(boardModel.toString())
        }
    }
}
