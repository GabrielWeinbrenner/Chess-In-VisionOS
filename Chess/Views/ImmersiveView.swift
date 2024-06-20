//
//  ImmersiveView.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/16/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @ObservedObject var chess3DViewModel: Chess3DViewModel
    @ObservedObject var selectionModel: SelectionModel
    @ObservedObject var boardModel: BoardModel
    init(chess3DViewModel: Chess3DViewModel) {
        self.chess3DViewModel = chess3DViewModel
        selectionModel = chess3DViewModel.selectionModel
        boardModel = chess3DViewModel.boardModel
    }
    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: .init(x: 0.2, y: 0.2)))
            chess3DViewModel.boardEntity.setParent(anchor)
            content.add(chess3DViewModel.boardEntity)
            content.add(anchor)
            Task {
                chess3DViewModel.renderBoardEntity()
            }
        }  update: { updateContent in
            updateContent.entities.removeAll()
            chess3DViewModel.renderBoardEntity()
            let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: .init(x: 0.2, y: 0.2)))
            chess3DViewModel.boardEntity.setParent(anchor)
            updateContent.add(chess3DViewModel.boardEntity)
            updateContent.add(anchor)
        }
        .gesture(
            SpatialTapGesture(count: 2)
                .onEnded({ value in
                    print(value)
                    chess3DViewModel.changePosition(value: value.location3D)
                })
        )
        .gesture(
            TapGesture()
                .targetedToAnyEntity()
                .onEnded({ value in
                    print(value)
                    for piece in chess3DViewModel.chessPieceVisual {
                        if let tappedParent = value.entity.parent, let pieceParent = piece.parent {
                            if tappedParent.name == pieceParent.name {
                                selectFileRank(cube: tappedParent)
                            }
                        }
                    }
                    for row in chess3DViewModel.boardVisual {
                        for cube in row {
                            if value.entity.name == cube.name {
                                selectFileRank(cube: cube)
                            }
                            
                        }
                    }
                })
        )
        
        
    }
    func selectFileRank(cube: Entity) {
        let fileIndex = cube.name.index(cube.name.startIndex, offsetBy: 0)
        let rankIndex = cube.name.index(cube.name.startIndex, offsetBy: 1)
        let fileCharacter = String(cube.name[fileIndex])
        let rankCharacter = String(cube.name[rankIndex])
        if let currentSquareModel = chess3DViewModel.boardModel.getSquareModel(file: fileCharacter, rank: rankCharacter) {
            chess3DViewModel.selectionModel.select(squareModel: currentSquareModel, boardModel: boardModel)
        }

    }
}

