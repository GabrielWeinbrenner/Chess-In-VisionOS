//
//  ChessPiece.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation
protocol ChessPiece {
//    static func == (lhs: ChessPiece, rhs: ChessPiece) -> Bool {
//        return (lhs.color == rhs.color) && (rhs.type == lhs.type)
//    }
//    enum Piece {
//        case pawn, rook, bishop, knight, king, queen
//    }
    var color: PlayerColor { get }
    var file: String? { get set }
    var rank: String? { get set }
    var hasMoved: Bool { get set }
    
    func validMoves(boardModel: BoardModel) -> [SquareModel]
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel, boardModel: BoardModel) -> Bool
    func toString() -> String
//    func renderPiece() -> Image
//    init(color: PlayerColor, type: Piece) {
//        self.color = color
//        self.type = type
//    }
}
