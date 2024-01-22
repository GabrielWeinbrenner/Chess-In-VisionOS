//
//  SquareModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import Foundation
class SquareModel: Identifiable, Equatable, ObservableObject, Codable {
    static func == (lhs: SquareModel, rhs: SquareModel) -> Bool {
        return (lhs.file == rhs.file) && (lhs.rank == rhs.rank)
    }
    
    let id: UUID
    let rank: String // rows 1...8
    let file: String // files a..h
    @Published var chessPiece: (any ChessPiece)?
    let chessPieceType: ChessPieceType?
    @Published var availableMove: Bool = false
    let color: SquareColor
    enum CodingKeys: CodingKey {
        case id, rank, file, chessPiece, availableMove, color, chessPieceType
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        rank = try container.decode(String.self, forKey: .rank)
        file = try container.decode(String.self, forKey: .file)
        
        if container.contains(.chessPieceType) {
            chessPieceType = try container.decode(ChessPieceType.self, forKey: .chessPieceType)
            switch chessPieceType {
            case .pawn:
                let piece = try container.decode(Pawn.self, forKey: .chessPiece)
                chessPiece = piece
            case .knight:
                let piece = try container.decode(Knight.self, forKey: .chessPiece)
                chessPiece = piece
            case .bishop:
                let piece = try container.decode(Bishop.self, forKey: .chessPiece)
                chessPiece = piece
            case .rook:
                let piece = try container.decode(Rook.self, forKey: .chessPiece)
                chessPiece = piece
            case .king:
                let piece = try container.decode(King.self, forKey: .chessPiece)
                chessPiece = piece
            case .queen:
                let piece = try container.decode(Queen.self, forKey: .chessPiece)
                chessPiece = piece
            case nil:
                chessPiece = nil
            }
        } else {
            chessPieceType = nil
        }
        availableMove = try container.decode(Bool.self, forKey: .availableMove)
        color = try container.decode(SquareColor.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(rank, forKey: .rank)
        try container.encode(file, forKey: .file)
        
        if let chessPiece = chessPiece {
            try container.encode(chessPiece.pieceType, forKey: .chessPieceType)
            switch chessPiece.pieceType {
            case .pawn:
                try container.encode(chessPiece as? Pawn, forKey: .chessPiece)
            case .knight:
                try container.encode(chessPiece as? Knight, forKey: .chessPiece)
            case .bishop:
                try container.encode(chessPiece as? Bishop, forKey: .chessPiece)
            case .rook:
                try container.encode(chessPiece as? Rook, forKey: .chessPiece)
            case .king:
                try container.encode(chessPiece as? King, forKey: .chessPiece)
            case .queen:
                try container.encode(chessPiece as? Queen, forKey: .chessPiece)
                
            }
        }

        try container.encode(availableMove, forKey: .availableMove)

        try container.encode(color, forKey: .color)
    }

    enum SquareColor: Codable{
        case black, white
    }
    
    init(file: String, rank: String, chessPiece: (any ChessPiece)?, color: SquareColor) {
        self.rank = rank
        self.file = file
        self.chessPiece = chessPiece
        self.chessPieceType = chessPiece?.pieceType
        self.color = color
        self.id = UUID()
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
    
    func getCoordinates() -> String {
        return "\(self.file)\(self.rank)"
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
