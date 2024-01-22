//
//  ChessControlView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/20/24.
//

import SwiftUI

struct ChessControlView: View {
    var body: some View {
        HStack {
            ControlButton(image: "plus.rectangle.fill.on.rectangle.fill")
            ControlButton(image: "trash.fill")
        }.padding(.vertical, 10)
    }
}

struct ControlButton: View {
    let image: String
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: image)
        })
    }
}
