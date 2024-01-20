//
//  ChessListView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/20/24.
//

import SwiftUI

struct ChessListItemView: View {
    @StateObject var boardModel: BoardModel
    var body: some View {
            GridRow() {
                VStack(alignment: .leading, content: {
                    BoardView(boardModel: boardModel, height: 20, width: 20, isPreview: true)
                })
                VStack(alignment: .leading, spacing: 2){
                    Text("\(boardModel.id)")
                        .cornerRadius(8)
                        .shadow(radius: 1, x: 1, y: 1)
                        .font(.title)
                    Text("Moves: ")
                        .cornerRadius(8)
                        .shadow(radius: 1, x: 1, y: 1)
                        .font(.subheadline)
                    Text("Date: ")
                        .cornerRadius(8)
                        .shadow(radius: 1, x: 1, y: 1)
                        .font(.subheadline)
                }
                .padding(.leading, 7.0)
        }
    }
}


var boardModel = BoardModel()
#Preview {
    ChessListItemView(boardModel: boardModel)
}

