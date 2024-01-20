//
//  Board.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

struct BoardView: View {

    @ObservedObject var boardModel: BoardModel
    var selectionModel: SelectionModel = SelectionModel()
    var height: CGFloat
    var width: CGFloat
    var isPreview: Bool = false
    var body: some View {
        if isPreview {
            VStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { col in
                            if let squareModel = boardModel.board[row][col] {
                                SquareView(squareModel: squareModel, boardModel: boardModel, height: height, width: width, selectionModel: selectionModel)
                            }
                        }
                    }
                }
            }
        } else {
            HStack(spacing: 5) {
                VStack(alignment: .leading) {
                    Text("Moves")
                        .font(.title)
                        .padding(.leading)
                    List {
                        ForEach(Array(boardModel.boardMoves.enumerated()), id: \.offset) { index, boardMove in
                                BoardMoveView(boardMove: boardMove, moveNumber: index+1 )
                            }
                    }
                }.padding(EdgeInsets(top: 50, leading: 30, bottom: 30, trailing: 30))
                VStack {
                    Text("\(boardModel.currentPlayer.toString())'s turn")
                        .font(.title3)
                    if boardModel.gameFinished {
                        Text("White has won by checkmate")
                    }
                    VStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<8, id: \.self) { col in
                                    if let squareModel = boardModel.board[row][col] {
                                        SquareView(squareModel: squareModel, boardModel: boardModel, height: height, width: width, selectionModel: selectionModel)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.trailing, 20)
                    .padding(.top, -100)
                
            }
        }
    }
}
