//
//  SquareModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import Foundation
class ChessPiece: Equatable {
    static func == (lhs: ChessPiece, rhs: ChessPiece) -> Bool {
        return (lhs.color == rhs.color) && (rhs.type == lhs.type)
    }
    
    enum Piece {
        case pawn, rook, bishop, knight, king, queen
    }
    let color: PlayerColor
    let type: Piece
    
    func toString() -> String {
        switch type {
            case .bishop: "B"
            case .king: "K"
            case .knight: "N"
            case .pawn: "p"
            case .queen: "Q"
            case .rook: "R"
        }
    }
    init(color: PlayerColor, type: Piece) {
        self.color = color
        self.type = type
    }
    
    
}
class SquareModel: Identifiable, Equatable {
    static func == (lhs: SquareModel, rhs: SquareModel) -> Bool {
        return (lhs.file == rhs.file) && (lhs.rank == rhs.rank)
    }
    
    let id: UUID = UUID()
    let rank: String // rows 1...8
    let file: String // files a..h
    let chessPiece: ChessPiece?
    
    enum SquareColor {
        case black, white
    }
    let color: SquareColor
    
    init(file: String, rank: String, chessPiece: ChessPiece?, color: SquareColor) {
        self.rank = rank
        self.file = file
        self.chessPiece = chessPiece
        self.color = color
    }
    
    func toString() -> String {
        return "(\(self.file), \(self.rank)) has a \(self.chessPiece?.toString() ?? "None") piece"
    }
    
//    func displaySquare() -> View {
//        
//    }
}
