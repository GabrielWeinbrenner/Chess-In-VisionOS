//
//  Rook.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class Rook: ChessPiece {
    
    var color: PlayerColor
    
    var file: String?
    
    var rank: String?
    
    var hasMoved: Bool = true

    func validMoves(boardModel : BoardModel) -> [SquareModel] {
        return []
    }
    
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel, boardModel: BoardModel) -> Bool {
        return true
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
