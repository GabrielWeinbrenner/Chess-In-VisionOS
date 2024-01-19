//
//  King.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class King: ChessPiece {
    var color: PlayerColor
    var pieceType: ChessPieceType = .king

    var file: String?
    
    var rank: String?
    
    var hasMoved: Bool = true
  
    func isChecked(row: Int, col: Int, boardModel: BoardModel) -> Bool {
        return isThreatenedByRowCol(boardModel: boardModel, row: row, col: col) ||
        isThreatenedDiagonally(boardModel: boardModel, row: row, col: col) ||
        isThreatenedByKnight(boardModel: boardModel, row: row, col: col)
    }
    
    func isThreatenedByRowCol(boardModel: BoardModel, row: Int, col: Int) -> Bool {
        for i in 0..<8 {
            if let square = boardModel.board[row][i], let piece = square.chessPiece {
                if piece is Rook || piece is Queen, piece.color != self.color {
                    return true
                }
            }

            if let square = boardModel.board[i][col], let piece = square.chessPiece {
                if piece is Rook || piece is Queen, piece.color != self.color {
                    return true
                }
            }
        }
        let directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
        for direction in directions {
            var r = row
            var c = col
            if r >= 0 && r < 8 && c >= 0 && c < 8 {
                r+=direction[0]
                c+=direction[1]
                if r > 0 && r < 8 && c > 0 && c < 8, let square = boardModel.board[r][c], let piece = square.chessPiece {
                    if piece is King, piece.color != self.color {
                        return true
                    }
                }
            }
        }

        return false

    }
    
    func isThreatenedDiagonally(boardModel: BoardModel, row: Int, col: Int) -> Bool {
        let directions = [(-1, -1), (-1, 1), (1, -1), (1, 1)]
        for direction in directions {
            var r = row
            var c = col
            while r >= 0 && r < 8 && c >= 0 && c < 8 {
                r += direction.0
                c += direction.1
                if r > 0 && r < 8 && c > 0 && c < 8, let square = boardModel.board[r][c], let piece = square.chessPiece {
                    if piece is Bishop || piece is Queen, piece.color != self.color {
                        return true
                    }
                }
            }
        }
        return false

    }
    
    func isThreatenedByKnight(boardModel: BoardModel, row: Int, col: Int) -> Bool {
        let knightMoves = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1), (0,0)]
//        print("----- \(boardModel.board[row][col]?.file) \(boardModel.board[row][col]?.rank)")
        for move in knightMoves {
            let r = row + move.0
            let c = col + move.1
//            if r > 0 && r < 8 && c > 0 && c < 8, let s = boardModel.board[r][c] {
//                print("\(s.file) \(s.rank) \(s.chessPiece)")
//            }
                
            if r > 0 && r < 8 && c > 0 && c < 8, let square = boardModel.board[r][c], let piece = square.chessPiece {
//                print("(\(square.file),\(square.rank)) \(self.toString()) \(piece.toString())")
                if piece is Knight, piece.color != self.color {
                    return true
                }
            }
        }
        return false

    }
    
    func validMoves(boardModel: BoardModel) -> [SquareModel] {
        var moves: [SquareModel]  = []
        guard let file = self.file else { return [] }
        guard let rank = self.rank else { return [] }

        if let rowCol = boardModel.convertFileRankToRowCol(file: file, rank: rank) {
            let directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
            for direction in directions {
                let currRow = rowCol.row+direction[0]
                let currCol = rowCol.col+direction[1]
                if currRow >= 0 && currRow < 8 && currCol >= 0 && currCol < 8 {
                    
                    // Check if there is a check then append the move
                    if self.isChecked(row: currRow, col: currCol, boardModel: boardModel) {
                        continue
                    }
                    if let squareInfo = boardModel.board[currRow][currCol] {
                        if !squareInfo.hasPiece() {
                            moves.append(squareInfo)
                        }
                        if squareInfo.hasOpponentPiece(currentPlayerColor: color) {
                            moves.append(squareInfo)
                        }
                    }
                }
            }
        }
        return moves
    }
    
    func checkmated(boardModel: BoardModel) -> Bool{
        guard let file = self.file else { return false }
        guard let rank = self.rank else { return false }

        if let rowCol = boardModel.convertFileRankToRowCol(file: file, rank: rank) {
            let validMoves = validMoves(boardModel: boardModel)
            let isChecked = isChecked(row: rowCol.row, col: rowCol.col, boardModel: boardModel)
            if validMoves.isEmpty && isChecked{
                return true
            }
        }
        return false
    }
        
    
    func movePiece(firstSpot: SquareModel, secondSpot: SquareModel, boardModel: BoardModel) -> Bool {
        if validMoves(boardModel: boardModel).contains(secondSpot){
            self.file = secondSpot.file
            self.rank = secondSpot.rank
            self.hasMoved = true
            return true
        }
        return false
    }
    
    func toString() -> String {
        return "\(color.toString())_king"

    }
    init(file: String? = nil, rank: String? = nil, color: PlayerColor) {
        self.file = file
        self.rank = rank
        self.color = color
    }

}
