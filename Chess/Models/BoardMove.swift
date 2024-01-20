//
//  BoardMOve.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/20/24.
//

import Foundation

struct BoardMove: Codable {
    
    var id: UUID = UUID()
    
    var firstMove: SquareModel
    var secondMove: SquareModel
    var player: Player
    enum CodingKeys: CodingKey {
        case firstMove, secondMove, player
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstMove, forKey: .firstMove)
        try container.encode(secondMove, forKey: .secondMove)
        try container.encode(player, forKey: .player)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        firstMove = try container.decode(SquareModel.self, forKey: .firstMove)
        secondMove = try container.decode(SquareModel.self, forKey: .secondMove)
        player = try container.decode(Player.self, forKey: .player)
    }
    
    init(firstMove: SquareModel, secondMove: SquareModel, player: Player) {
        self.firstMove = firstMove
        self.secondMove = secondMove
        self.player = player
    }
}
