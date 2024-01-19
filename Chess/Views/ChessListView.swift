//
//  ListView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/18/24.
//

import SwiftUI

struct ChessListView: View {
    
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var chessModel: ChessModel
    var body: some View {
        var boardModels = chessModel.getBoardModels()
        VStack(alignment: .leading) {
            ForEach(boardModels, id: \.self) { board in
                Text("\(board.id)")
                    .padding(12)
                    .cornerRadius(8)
                    .shadow(radius: 1, x: 1, y: 1)
                    .draggable(board)
            }
        }
            .onAppear() {
                openWindow(id: "ChessPlayerView")
            }
    }
}

//#Preview {
//    ChessListView()
//}
