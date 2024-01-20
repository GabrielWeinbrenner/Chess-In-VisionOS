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
            Text("Chess Games")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ScrollView(showsIndicators: false) {
                Grid() {
                    ForEach(boardModels, id: \.self) { boardModel in
                        ChessListItemView(boardModel: boardModel)
                        .draggable(boardModel.self, preview: {
                            BoardView(boardModel: boardModel, height: 100, width: 100, isPreview: true)
                        })
                        .onTapGesture {
                            let address = Unmanaged.passUnretained(boardModel).toOpaque()
                            print("CLICK \(address) \(boardModel.id)")
                            chessModel.setCurrentBoardModel(boardModel: boardModel)
                       }
                    }
                    
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        .onAppear() {
            openWindow(id: "ChessPlayerView")
        }
    }
}

var chessModel = ChessModel()
#Preview {
    ChessListView()
        .environmentObject(chessModel)
}

