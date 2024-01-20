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
        let boardModels = chessModel.getBoardModels()
        VStack(alignment: .leading) {
            ForEach(boardModels, id: \.self) { board in
                Text("\(board.id)")
                    .padding(12)
                    .cornerRadius(8)
                    .shadow(radius: 1, x: 1, y: 1)
                    .draggable(board.self, preview: {
                        BoardView(boardModel: board)
                    })
                    .onTapGesture {
                        let address = Unmanaged.passUnretained(board).toOpaque()
                        print("CLICK \(address) \(board.id)")
                        chessModel.setCurrentBoardModel(boardModel: board)
                    }
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
