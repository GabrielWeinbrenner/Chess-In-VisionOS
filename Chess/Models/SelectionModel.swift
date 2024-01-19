//
//  SelectionModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/18/24.
//

import Foundation

class SelectionModel: ObservableObject {
    @Published var firstSelection: SquareModel? = nil
    @Published var secondSelection: SquareModel? = nil
    
    func select(squareModel: SquareModel, boardModel: BoardModel) {
        if ( firstSelection == nil ) {
            if let chessPiece = squareModel.chessPiece {
                if chessPiece.color != boardModel.currentPlayer {
                    return
                }
                for squarePiece in chessPiece.validMoves(boardModel: boardModel) {
                    squarePiece.setAvailableMove(toggle: true)
                }
                self.firstSelection = squareModel
            }
        } else if ( secondSelection == nil) {
            self.secondSelection = squareModel
            let chessPiece = firstSelection?.chessPiece
            if let validMoves = chessPiece?.validMoves(boardModel: boardModel)  {
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
}
