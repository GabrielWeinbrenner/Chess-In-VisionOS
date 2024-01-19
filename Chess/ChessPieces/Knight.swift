//
//  Knight.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/17/24.
//

import Foundation

class Knight: ChessPiece {
    var pieceType: ChessPieceType = .knight
    
    var color: PlayerColor
    
    var file: String?
    
    var rank: String?
    
    var hasMoved: Bool = true

    func validMoves(boardModel: BoardModel) -> [SquareModel] {
        var moves: [SquareModel]  = []
        guard let file = self.file else { return [] }
        guard let rank = self.rank else { return [] }
        if let rowCol = boardModel.convertFileRankToRowCol(file: file, rank: rank) {
            let knightMoves = [[1,2], [1, -2], [-1, 2], [-1,-2], [2, 1], [-2, 1], [2, -1], [-2,-1]]
            for knightMove in knightMoves {
                let newPos = [rowCol.row + knightMove[0], rowCol.col + knightMove[1]]
                if(newPos[0] < 0 || newPos[0] > 7 || newPos[1] < 0 || newPos[1] > 7) { continue }
                if let newSquare = boardModel.board[newPos[0]][newPos[1]] {
                    if newSquare.hasPiece() {
                        if newSquare.hasOpponentPiece(currentPlayerColor: color) == true {
                            moves.append(newSquare)
                        }
                    } else {
                        moves.append(newSquare)
                    }
                }
            }
        }
        return moves
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
        return "\(color.toString())_knight"

    }
    init(file: String? = nil, rank: String? = nil, color: PlayerColor) {
        self.file = file
        self.rank = rank
        self.color = color
    }
    enum CodingKeys: String, CodingKey {
        case color
        case file
        case rank
        case hasMoved
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(color, forKey: .color)
        try container.encode(file, forKey: .file)
        try container.encode(rank, forKey: .rank)
        try container.encode(hasMoved, forKey: .hasMoved)

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        color = try container.decode(PlayerColor.self, forKey: .color)
        file = try container.decodeIfPresent(String.self, forKey: .file)
        rank = try container.decodeIfPresent(String.self, forKey: .rank)
        hasMoved = try container.decode(Bool.self, forKey: .hasMoved)

    }
    
}
