//
//  BoardMoveView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/20/24.
//

import SwiftUI

struct BoardMoveView: View {
    var boardMove: BoardMove
    var moveNumber: Int
    var body: some View {
        HStack {
            Text("Move: \(moveNumber)")
            Text("\(boardMove.firstMove.file)\(boardMove.firstMove.rank) to \(boardMove.secondMove.file)\(boardMove.secondMove.rank)")
            Text(boardMove.player.playerColor == .black ? "Black" : "White")
        }
    }
}

