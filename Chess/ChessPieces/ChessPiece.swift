//
//  ChessPiece.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation
protocol ChessPiece: Codable {
//    static func == (lhs: ChessPiece, rhs: ChessPiece) -> Bool {
//        return (lhs.color == rhs.color) && (rhs.type == lhs.type)
//    }
//    enum Piece {
//        case pawn, rook, bishop, knight, king, queen
//    }
    var color: PlayerColor { get set }
    var file: String? { get set }
    var rank: String? { get set }
    var hasMoved: Bool { get set }
    var pieceType: ChessPieceType { get }
    
    func validMoves(boardModel: BoardModel) -> [SquareModel]
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel, boardModel: BoardModel) -> Bool
    func toString() -> String

}

enum ChessPieceType: String, Codable {
    case pawn, knight, bishop, rook, queen, king
    
    var metatype: ChessPiece.Type {
        switch self {
        case .bishop:
            return Bishop.self
        case .king:
            return King.self
        case .knight:
            return Knight.self
        case .pawn:
            return Pawn.self
        case .queen:
            return Queen.self
        case .rook:
            return Rook.self
            
        }
    }
}
