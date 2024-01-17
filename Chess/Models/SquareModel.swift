//
//  SquareModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import Foundation
class SquareModel: Identifiable, Equatable, ObservableObject {
    static func == (lhs: SquareModel, rhs: SquareModel) -> Bool {
        return (lhs.file == rhs.file) && (lhs.rank == rhs.rank)
    }
    
    let id: UUID = UUID()
    let rank: String // rows 1...8
    let file: String // files a..h
    @Published var chessPiece: (any ChessPiece)?
    @Published var availableMove: Bool = false
    enum SquareColor {
        case black, white
    }
    let color: SquareColor
    
    init(file: String, rank: String, chessPiece: (any ChessPiece)?, color: SquareColor) {
        self.rank = rank
        self.file = file
        self.chessPiece = chessPiece
        self.color = color
    }
    
    func setPiece(piece: (any ChessPiece)?) {
        self.chessPiece = piece
    }
    func hasPiece() -> Bool {
        if (self.chessPiece == nil) {  return false } else { return true }
    }
    func hasOpponentPiece(currentPlayerColor: PlayerColor) -> Bool {
        if !hasPiece() { return false }
        if self.chessPiece?.color == currentPlayerColor { return false }
        return true
    }
    func toString() -> String {
        return "(\(self.file), \(self.rank)) has a \(self.chessPiece?.toString() ?? "None") piece"
    }
    
    func setAvailableMove(toggle: Bool) {
        self.availableMove = toggle
    }
    
//    func displaySquare() -> View {
//        
//    }
}
