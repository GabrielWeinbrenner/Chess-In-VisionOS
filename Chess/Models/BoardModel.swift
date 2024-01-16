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
struct Player {
    var playerColor: PlayerColor
    var chessPieces: [ChessPiece]
    
}
class BoardModel {
    func fileRankConvert(col: Int, row: Int) -> (file: String, rank: String, color: SquareModel.SquareColor, chessPiece: ChessPiece?){
        let files = ["a", "b", "c", "d", "e", "f", "g", "h"]
        guard col >= 0, col < 8, row >= 0, row < 8 else {
            fatalError("Invalid column or row. Must be between 0 and 7.")
        }
        
        let file = files[col]
        let rank = String(8 - row)
        let color = (col+row) % 2 == 0 ? SquareModel.SquareColor.black : SquareModel.SquareColor.white
        var chessPieceColor: PlayerColor
        var chessPieceType: ChessPiece.Piece
        
        if(row == 0 || row == 1) {
            chessPieceColor = .white
            if(row == 1) {
                chessPieceType = .pawn
            }
        } else if(row == 7 || row == 6) {
            chessPieceColor = .black
            if(row == 6) {
                chessPieceType = .pawn
            }
        } else {
            return (file, rank, color, nil)
        }
        
        switch col {
        case 0, 7:
            chessPieceType = .rook
        case 1, 6:
            chessPieceType = .knight
        case 2,5:
            chessPieceType = .bishop
        case 3:
            chessPieceType = .queen
        case 4:
            chessPieceType = .king
        default:
            fatalError("Invalid Column")
        }
        let chessPiece = ChessPiece(color: chessPieceColor, type: chessPieceType)
        
        chessPieceColor == .white ? playerOne.chessPieces.append(chessPiece) : playerTwo.chessPieces.append(chessPiece)
        return (file, rank, color, chessPiece)
    }

    func initializeBoard() {
        for row in 0..<8 {
            for col in 0..<8 {
                let position = fileRankConvert(col: col, row: row)
                self.board[row][col] = SquareModel(file: position.file, rank: position.rank, chessPiece: position.chessPiece, color: position.color)
            }
        }
    }
    
    var board: [[SquareModel?]]
    var currentPlayer: PlayerColor
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
