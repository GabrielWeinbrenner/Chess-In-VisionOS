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
    init(chess3DViewModel: Chess3DViewModel) {
        self.chess3DViewModel = chess3DViewModel
        selectionModel = chess3DViewModel.selectionModel
    }
    var body: some View {
        RealityView { content in
            content.add(chess3DViewModel.boardEntity)
            Task {
                chess3DViewModel.renderBoardEntity()
            }
        }  update: { updateContent in
//            let selectionModel = chess3DViewModel.selectionModel
//            var updatedEntities = [String]()
//            if let firstSelection = selectionModel.firstSelection {
//                updatedEntities.append(firstSelection.getCoordinates())
//                if let chessPiece = firstSelection.chessPiece {
//                    updatedEntities.append(chessPiece.toString())
//                }
//            }
//            if let secondSelection = selectionModel.secondSelection {
//                updatedEntities.append(secondSelection.getCoordinates())
//                if let chessPiece = secondSelection.chessPiece {
//                    updatedEntities.append(chessPiece.toString())
//                }
//            }
//            for content in updateContent.entities {
//                if updatedEntities.contains(content.name) {
//                    updateContent.remove(content)
//                }
//            }
//            for content in updateContent.entities {
//                updateContent.remove(content)
//            }
            updateContent.entities.removeAll()
            
            print("updated")
            chess3DViewModel.renderBoardEntity()
            updateContent.add(chess3DViewModel.boardEntity)
//            for row in chess3DViewModel.boardVisual {
//                for item in row {
////                    if updatedEntities.contains(item.name) {
//                        updateContent.add(item)
////                    }
//                }
//            }
//            for chessPieceVisual in chess3DViewModel.chessPieceVisual {
////                if updatedEntities.contains(chessPieceVisual.name) {
//                    updateContent.add(chessPieceVisual)
////                }
//            }
        }.gesture(
            TapGesture()
                .targetedToAnyEntity()
                .onEnded({ value in
                    print("------")
                    print(value.entity.name)
                    for piece in chess3DViewModel.chessPieceVisual {
                        if value.entity.name == piece.name {
                            print(value.entity.name)
                        }
                    }
                    for row in chess3DViewModel.boardVisual {
                        for cube in row {
                            if value.entity.name == cube.name {
                                let fileIndex = cube.name.index(cube.name.startIndex, offsetBy: 0)
                                let rankIndex = cube.name.index(cube.name.startIndex, offsetBy: 1)
                                let fileCharacter = String(cube.name[fileIndex])
                                let rankCharacter = String(cube.name[rankIndex])
                                if let currentSquareModel = chess3DViewModel.boardModel.getSquareModel(file: fileCharacter, rank: rankCharacter) {
                                    chess3DViewModel.selectionModel.select(squareModel: currentSquareModel, boardModel: boardModel)
                                }
                            }
                            
                        }
                    }
                })
        )
    }
}


//#Preview {
//    ImmersiveView()
//        .previewLayout(.sizeThatFits)
//}
