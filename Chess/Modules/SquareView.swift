//
//  Square.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI

let BLACK_SQUARE: Color = Color(red: CGFloat(118.0/255.0), green: CGFloat(150.0/255.0), blue: CGFloat(86.0/255.0))
let WHITE_SQUARE: Color = Color(red: CGFloat(238.0/255.0), green: CGFloat(238.0/255.0), blue: CGFloat(210.0/255.0))
struct SquareView: View {
    var squareModel: SquareModel
    var boardModel: BoardModel
    @ObservedObject var selectionModel: SelectionModel
    var body: some View {
        return ZStack {
            Rectangle()
                .fill(squareModel.color == .black ? BLACK_SQUARE : WHITE_SQUARE)
                .border(selectionModel.contains(squareModel: squareModel) ? Color.red : Color.gray, width: 1)
                .frame(width: 60, height: 60)
            if let chessPiece = squareModel.chessPiece {
                Image(chessPiece.toString())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60, alignment: .center)
                    .clipped()
            }
            if squareModel.availableMove {
                Image(systemName: "circle.fill")
                    .font(.system(size: 40, weight: .light))
                    .foregroundColor(.white)
                    .imageScale(.small)
            }
        }.onTapGesture(perform: {
            print("\(squareModel.toString())")
            selectionModel.select(squareModel: squareModel, boardModel: boardModel)
        })
    }
}

//var squareModel = SquareModel(file: "e", rank: "8", chessPiece: Pawn(file: "e", rank: "8", color: PlayerColor.black), color: SquareModel.SquareColor.black)
//var boardModel = BoardModel()
//var selectionModel = SelectionModel(boardModel: boardModel)
//#Preview {
//    SquareView(squareModel: squareModel, selectionModel: selectionModel)
//}
