//
//  Bishop.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class Bishop: ChessPiece {
    var color: PlayerColor
    var pieceType: ChessPieceType = .bishop

    var file: String?
    
    var rank: String?
    
    var hasMoved: Bool = true

    func validMoves(boardModel : BoardModel) -> [SquareModel] {
        var moves: [SquareModel]  = []
        guard let file = self.file else { return [] }
        guard let rank = self.rank else { return [] }
        func checkCollision(squareInfo: SquareModel) -> Bool {
            if squareInfo.hasPiece() {
                if squareInfo.hasOpponentPiece(currentPlayerColor: color) {
                    moves.append(squareInfo)
                }
                return true
            }
            return false
        }
        if let rowCol = boardModel.convertFileRankToRowCol(file: file, rank: rank) {
            let directions = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
            for direction in directions {
                var currRow = rowCol.row+direction[0]
                var currCol = rowCol.col+direction[1]
                while(currRow >= 0 && currRow < 8 && currCol >= 0 && currCol < 8) {
                    if let squareInfo = boardModel.board[currRow][currCol] {
                        if checkCollision(squareInfo: squareInfo) { break }
                        moves.append(squareInfo)
                    }
                    currRow+=direction[0]
                    currCol+=direction[1]
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
        return "\(color.toString())_bishop"

    }
    
    init(file: String? = nil, rank: String? = nil, color: PlayerColor) {
        self.file = file
        self.rank = rank
        self.color = color
    }
}
