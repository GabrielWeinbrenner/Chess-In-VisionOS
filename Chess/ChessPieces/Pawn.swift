//
//  Pawn.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class Pawn: ChessPiece {
    var pieceType: ChessPieceType = .pawn

    
    var hasMoved: Bool = false
    
    var file: String?
    
    var rank: String?
    
    var color: PlayerColor
  
    init(file: String? = nil, rank: String? = nil, color: PlayerColor) {
        self.file = file
        self.rank = rank
        self.color = color
    }
    
    func validMoves(boardModel: BoardModel) -> [SquareModel] {
        var moves: [SquareModel]  = []
        let direction: Int = self.color == PlayerColor.black ? -1 : 1
        guard let file = self.file else { return [] }
        guard let rank = self.rank else { return [] }
        if let rowCol = boardModel.convertFileRankToRowCol(file: file, rank: rank) {
            // Getting fatal error here
            if let oneUp = (boardModel.board[rowCol.row + (direction)][rowCol.col]), let twoUp = (boardModel.board[rowCol.row + (direction*2)][rowCol.col]) {
                if hasMoved == false {
                    if !oneUp.hasPiece() && !twoUp.hasPiece() {
                        moves.append(twoUp)
                    }
                }
                if !oneUp.hasPiece() {
                    moves.append(oneUp)
                }
                let rightUpCol = rowCol.col - 1
                let rightUpRow = rowCol.row + direction
                if rightUpCol >= 0, rightUpRow >= 0, rightUpRow < boardModel.board.count,
                   let rightUp = boardModel.board[rightUpRow][rightUpCol], rightUp.hasOpponentPiece(currentPlayerColor: color) {
                    moves.append(rightUp)
                }

                let leftUpCol = rowCol.col + 1
                let leftUpRow = rowCol.row + direction
                if leftUpCol < boardModel.board[rowCol.row].count, leftUpRow >= 0, leftUpRow < boardModel.board.count,
                   let leftUp = boardModel.board[leftUpRow][leftUpCol], leftUp.hasOpponentPiece(currentPlayerColor: color) {
                    moves.append(leftUp)
                }

                
            }
        }
        
        return moves
    }
    
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel, boardModel: BoardModel) -> Bool {
        if validMoves(boardModel: boardModel).contains(secondSpot){
            self.file = secondSpot.file
            self.rank = secondSpot.rank
            self.hasMoved = true
            return true
        }
        return false
    }
    
    func toString() -> String {
        return "\(color.toString())_pawn"
    }
}
