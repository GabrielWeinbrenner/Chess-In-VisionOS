//
//  King.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class King: ChessPiece {

    var color: PlayerColor
    
    var file: String?
    
    var rank: String?
    
    var hasMoved: Bool = true
    
    func validMoves(boardModel: BoardModel) -> [SquareModel] {
        return []
    }
    
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel, boardModel: BoardModel) -> Bool {
        return true
    }
    
    func toString() -> String {
        return "\(color.toString())_king"

    }
//    func renderPiece() -> Image {
//        return Image(self.toString())
//    }
    init(file: String? = nil, rank: String? = nil, color: PlayerColor) {
        self.file = file
        self.rank = rank
        self.color = color
    }
}