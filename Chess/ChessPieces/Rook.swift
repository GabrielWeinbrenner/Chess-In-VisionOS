//
//  Rook.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class Rook: ChessPiece {
    var pieceType: ChessPieceType = .rook

    var color: PlayerColor
    
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
            for i in (0..<rowCol.col).reversed() {
                if let squareInfo = boardModel.board[rowCol.row][i] {
                    if checkCollision(squareInfo: squareInfo) { break }
                    moves.append(squareInfo)
                }

            }
            
            for i in rowCol.col+1..<8 {
                if let squareInfo = boardModel.board[rowCol.row][i] {
                    if checkCollision(squareInfo: squareInfo) { break }
                    moves.append(squareInfo)
                }

            }
            
            for i in (0..<rowCol.row).reversed() {
                if let squareInfo = boardModel.board[i][rowCol.col] {
                    if checkCollision(squareInfo: squareInfo) { break }
                    moves.append(squareInfo)
                }

            }
            for i in rowCol.row+1..<8 {
                if let squareInfo = boardModel.board[i][rowCol.col] {
                    if checkCollision(squareInfo: squareInfo) { break }
                    moves.append(squareInfo)
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

    
    init(file: String? = nil, rank: String? = nil, color: PlayerColor) {
        self.file = file
        self.rank = rank
        self.color = color
    }
    
    func toString() -> String {
        return "\(color)_rook"
    }
}
