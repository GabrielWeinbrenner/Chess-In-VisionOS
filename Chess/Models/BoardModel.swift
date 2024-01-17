//
//  BoardModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import Foundation

enum PlayerColor {
    case black, white
}
extension PlayerColor {
    func toString() -> String {
        switch self {
        case .black:
            return "black"
        case .white:
            return "white"
        }
    }
}

struct Player {
    var playerColor: PlayerColor
    var chessPieces: [any ChessPiece]
    
}
class BoardModel: ObservableObject {
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
                changePlayer()
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
    
    var board: [[SquareModel?]]
    @Published var currentPlayer: PlayerColor
    var playerOne: Player
    var playerTwo: Player
    init() {
        self.board = Array(repeating: Array(repeating: nil, count: 8), count: 8)
        self.playerOne = Player(playerColor: .white, chessPieces: [])
        self.playerTwo = Player(playerColor: .black, chessPieces: [])
        self.currentPlayer = .white
        initializeBoard()
    }
}
