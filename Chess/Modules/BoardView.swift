//
//  Board.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

class SelectionModel: ObservableObject {
    @Published var firstSelection: SquareModel? = nil
    @Published var secondSelection: SquareModel? = nil
    @Published var boardModel: BoardModel
    
    func select(squareModel: SquareModel) {
        if ( firstSelection == nil ) {
            if let chessPiece = squareModel.chessPiece {
                if chessPiece.color != boardModel.currentPlayer {
                    return
                }
                for squarePiece in chessPiece.validMoves(boardModel: self.boardModel) {
                    squarePiece.setAvailableMove(toggle: true)
                }
                self.firstSelection = squareModel
            }
        } else if ( secondSelection == nil) {
            self.secondSelection = squareModel
            let chessPiece = firstSelection?.chessPiece
            if let validMoves = chessPiece?.validMoves(boardModel: self.boardModel)  {
                for squarePiece in validMoves{
                    squarePiece.setAvailableMove(toggle: false)
                }
            }
            _ = boardModel.movePiece(firstSpot: firstSelection!, secondSpot: secondSelection!)
            
            self.firstSelection = nil
            self.secondSelection = nil
        } else {
            self.firstSelection = nil
            self.secondSelection = nil
            
        }
    }
    
    func contains(squareModel: SquareModel) -> Bool {
        return (firstSelection == squareModel) || (secondSelection == squareModel)
    }
    
    init(boardModel: BoardModel) {
        self.boardModel = boardModel
    }
}
struct BoardView: View {

    @ObservedObject var boardModel: BoardModel = BoardModel()
    var selectionModel: SelectionModel
    
    init() {
        let model = BoardModel()
        self.boardModel = model
        let selectionModel = SelectionModel(boardModel: model)
        self.selectionModel = selectionModel
    }
    var body: some View {
        VStack {
            Text("\(boardModel.currentPlayer.toString())'s turn")
            VStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { col in
                            if let squareView = boardModel.board[row][col] {
                                SquareView(squareModel: squareView, selectionModel: selectionModel)
                            }
                        }
                    }
                }
            }.padding()
            
        }
    }
}

#Preview {
    BoardView()
}
