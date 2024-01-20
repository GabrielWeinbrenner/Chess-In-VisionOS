//
//  BoardModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

enum PlayerColor {
    case black, white
}
extension PlayerColor: Codable {
    func toString() -> String {
        switch self {
        case .black:
            return "black"
        case .white:
            return "white"
        }
    }
}

struct Player: Codable {
    var playerColor: PlayerColor
    var chessPieces: [any ChessPiece]
    enum CodingKeys: CodingKey {
        case playerColor, chessPieces
    }
    
    init(playerColor: PlayerColor, chessPieces: [any ChessPiece]) {
        self.playerColor = playerColor
        self.chessPieces = chessPieces
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(playerColor, forKey: .playerColor)

        var chessPiecesContainer = container.nestedUnkeyedContainer(forKey: .chessPieces)
        for piece in chessPieces {
            switch piece.pieceType {
            case .pawn:
                try chessPiecesContainer.encode(piece as? Pawn)
            case .knight:
                try chessPiecesContainer.encode(piece as? Knight)
            case .bishop:
                try chessPiecesContainer.encode(piece as? Bishop)
            case .rook:
                try chessPiecesContainer.encode(piece as? Rook)
            case .king:
                try chessPiecesContainer.encode(piece as? King)
            case .queen:
                try chessPiecesContainer.encode(piece as? Queen)
            }
        }
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        playerColor = try container.decode(PlayerColor.self, forKey: .playerColor)

        var chessPiecesArray: [any ChessPiece] = []
        var chessPiecesContainer = try container.nestedUnkeyedContainer(forKey: .chessPieces)
        while !chessPiecesContainer.isAtEnd {
            if let pawn = try? chessPiecesContainer.decode(Pawn.self) {
                chessPiecesArray.append(pawn)
            }
            if let knight = try? chessPiecesContainer.decode(Knight.self) {
                chessPiecesArray.append(knight)
            }
            if let bishop = try? chessPiecesContainer.decode(Bishop.self) {
                chessPiecesArray.append(bishop)
            }
            if let rook = try? chessPiecesContainer.decode(Rook.self) {
                chessPiecesArray.append(rook)
            }
            if let king = try? chessPiecesContainer.decode(King.self) {
                chessPiecesArray.append(king)
            }
            if let queen = try? chessPiecesContainer.decode(Queen.self) {
                chessPiecesArray.append(queen)
            }
        }
        self.chessPieces = chessPiecesArray
    }

}
class BoardModel: ObservableObject, Codable, Identifiable, Observable  {
    
    var id: UUID = UUID()
    var board: [[SquareModel?]]
    @Published var currentPlayer: PlayerColor
    var playerOne: Player
    var playerTwo: Player
    @Published var gameFinished: Bool = false
    var boardMoves: [BoardMove] = []
    enum CodingKeys: CodingKey {
        case id, board, currentPlayer, playerOne, playerTwo, gameFinished, boardMoves
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(board, forKey: .board)
        try container.encode(currentPlayer, forKey: .currentPlayer)
        try container.encode(playerOne, forKey: .playerOne)
        try container.encode(playerTwo, forKey: .playerTwo)
        try container.encode(gameFinished, forKey: .gameFinished)
        try container.encode(boardMoves, forKey: .boardMoves)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        board = try container.decode([[SquareModel?]].self, forKey: .board)
        currentPlayer = try container.decode(PlayerColor.self, forKey: .currentPlayer)
        playerOne = try container.decode(Player.self, forKey: .playerOne)
        playerTwo = try container.decode(Player.self, forKey: .playerTwo)
        gameFinished = try container.decode(Bool.self, forKey: .gameFinished)
        boardMoves = try container.decode([BoardMove].self, forKey: .boardMoves)
    }


    init() {
        self.board = Array(repeating: Array(repeating: nil, count: 8), count: 8)
        self.playerOne = Player(playerColor: .white, chessPieces: [])
        self.playerTwo = Player(playerColor: .black, chessPieces: [])
        self.currentPlayer = .white
        initializeBoard()
    }

    func initialColPieceType(col: Int, color: PlayerColor, file: String, rank: String) -> (any ChessPiece){
        switch col {
        case 0, 7:
            return Rook(file: file, rank: rank, color: color)
        case 1, 6:
            return Knight(file: file, rank: rank, color: color)
        case 2,5:
            return Bishop(file: file, rank: rank, color: color)
        case 3:
            return Queen(file: file, rank: rank, color: color)
        case 4:
            return King(file: file, rank: rank, color: color)
        default:
            fatalError("Invalid Column")
        }
    }
    
    func getKings() -> [King] {
        var kings: [King] = []
        for piece in playerOne.chessPieces {
            if let king = piece as? King {
                kings.append(king)
            }
        }
        for piece in playerTwo.chessPieces {
            if let king = piece as? King {
                kings.append(king)
            }
        }
        return kings
    }
    func fileRankConvert(col: Int, row: Int) -> (file: String, rank: String, color: SquareModel.SquareColor, chessPiece: (any ChessPiece)?){
        let files = ["a", "b", "c", "d", "e", "f", "g", "h"]
        guard col >= 0, col < 8, row >= 0, row < 8 else {
            fatalError("Invalid column or row. Must be between 0 and 7.")
        }
        
        let file = files[col]
        let rank = String(8 - row)
        let color = (col+row) % 2 == 0 ? SquareModel.SquareColor.black : SquareModel.SquareColor.white
        if(row == 1 || row == 6) {
            let chessPieceColor = row == 1 ? PlayerColor.white : PlayerColor.black
            let chessPiece = Pawn(file: file, rank: rank, color: chessPieceColor)
            return (file, rank, color, chessPiece)
        } else if row == 0 || row == 7 {
            let chessPieceColor = row == 0 ? PlayerColor.white : PlayerColor.black
            let chessPiece = initialColPieceType(col: col, color: chessPieceColor, file: file, rank: rank)
            return (file, rank, color, chessPiece)
        }
        return (file, rank, color, nil)
    }
    func assignChessPieceToPlayer(chessPiece: any ChessPiece, row: Int) {
        if row == 0 || row == 1 {
            playerOne.chessPieces.append(chessPiece)
        } else if row == 6 || row == 7 {
            playerTwo.chessPieces.append(chessPiece)
        }
    }
    func initializeBoard() {
        for col in 0..<8 {
            for row in 0..<8 {
                let position = fileRankConvert(col: col, row: row)
                let squareInfo = SquareModel(file: position.file, rank: position.rank, chessPiece: position.chessPiece, color: position.color)
                self.board[row][col] = squareInfo
                if let chessPiece = position.chessPiece {
                    assignChessPieceToPlayer(chessPiece: chessPiece, row: row)
                }
            }
        }
    }
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel) -> Bool {
        if let movedPiece = firstSpot.chessPiece {
            if movedPiece.color == currentPlayer && movedPiece.movePiece(firstSpot: firstSpot, secondSpot: secondSpot, boardModel: self) {
                firstSpot.setPiece(piece: nil)
                secondSpot.setPiece(piece: movedPiece)
                for king in getKings() {
                    if king.checkmated(boardModel: self) {
                        gameFinished = true
                    }
                }
                var playerMove: Player = currentPlayer == .black ? playerTwo : playerOne
                var newMove: BoardMove = BoardMove(firstMove: firstSpot, secondMove: secondSpot, player: playerMove)
                changePlayer()
                boardMoves.append(newMove)
                return true
            } else {
                return false
            }
        }
        
        return false
    }
    
    func changePlayer() {
        currentPlayer = currentPlayer == .black ? .white : .black
    }
    
    func convertFileRankToRowCol(file: String, rank: String) -> (row: Int, col: Int)? {
        guard file.count == 1, let rankInt = Int(rank), rankInt >= 1, rankInt <= 8 else {
            return nil
        }

        let fileLowercased = file.lowercased()
        guard let fileAsciiValue = fileLowercased.unicodeScalars.first?.value,
              let aAsciiValue = "a".unicodeScalars.first?.value else {
            return nil
        }

        let col = Int(fileAsciiValue - aAsciiValue)
        
        let row = 8 - rankInt

        if col < 0 || col > 7 {
            return nil
        }

        return (row, col)
    }


    func getSquareModel(file: String, rank: String, row: Int? = nil, col: Int? = nil ) -> SquareModel? {
        if let rowCol = convertFileRankToRowCol(file: file, rank: rank) {
            return self.board[rowCol.row][rowCol.col]
        }
        return nil
    }
    
    
}

extension BoardModel {
    func toString() -> String {
        print("\(self.id)")
        var boardString = ""
        for row in 0..<8 {
            for col in 0..<8 {
                if let square = board[row][col], let chessPiece = square.chessPiece {
                    boardString += chessPiece.toString() + " "
                } else {
                    boardString += "---- "
                }
            }
            boardString += "\n"
        }
        return boardString
    }
}

extension BoardModel: Hashable {
    static func == (lhs: BoardModel, rhs: BoardModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension BoardModel: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .BoardModel)
    }
}
extension UTType {
    static var BoardModel: UTType { UTType(exportedAs: "com.gabrielweinbrenner.BoardModel") }
}
