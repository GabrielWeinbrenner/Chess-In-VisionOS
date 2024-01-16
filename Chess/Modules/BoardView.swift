//
//  Board.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

struct BoardView: View {

    var boardModel: BoardModel = BoardModel()
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<8, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { col in
                        if let squareView = boardModel.board[row][col] {
                            SquareView(squareModel: squareView)
                        }
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    BoardView()
}
