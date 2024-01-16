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
    var body: some View {
        ZStack {
            Rectangle()
                .fill(squareModel.color == .black ? BLACK_SQUARE : WHITE_SQUARE)
                .border(Color.gray, width: 1)
                .frame(width: 60, height: 60)
            if let chessPiece = squareModel.chessPiece {
                Text(chessPiece.toString())
                    .foregroundStyle(squareModel.color == .black ? Color.white : Color.black)
            }
        }
    }
}

var squareModel = SquareModel(file: "e", rank: "8", chessPiece: ChessPiece(color: .white, type: .bishop), color: .black)
#Preview {
    SquareView(squareModel: squareModel)
}
