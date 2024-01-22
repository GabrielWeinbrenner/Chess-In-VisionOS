//
//  ViewModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/18/24.
//

import Foundation
import RealityKit
import SwiftUI
class Chess3DViewModel: ObservableObject {
    var boardVisual: [[Entity]]
    var chessPieceVisual: [Entity]
    var boardEntity: Entity
    var boardModel: BoardModel
    var height: Float = 0.2
    var width: Float = 0.2
    var depth: Float = 0.2
    var selectionModel: SelectionModel = SelectionModel()
    init(boardModel: BoardModel) {
        boardVisual = Array(repeating: Array(repeating: Entity(), count: 8), count: 8)
        chessPieceVisual = []
        self.boardModel = boardModel
        self.boardEntity = Entity()
    }
    func renderBoardEntity() {
        self.boardEntity = Entity()
        renderBoardVisual()
        for row in boardVisual {
            for item in row {
                self.boardEntity.addChild(item)
            }
        }
    }
    func renderBoardVisual() {
        // Shoudl i reset the board?
        chessPieceVisual = []
        for row in 0..<8 {
            for col in 0..<8 {
                if let squareModel = boardModel.board[row][col] {
                    let chessCube: ChessCube = ChessCube(height: height, width: width, depth: depth, squareModel: squareModel, selectionModel: selectionModel)
                    if let chessCubeEntity = chessCube.createBoardCube() {
                        chessCubeEntity.position.x += width*Float(row)
                        chessCubeEntity.position.y = depth
                        chessCubeEntity.position.z += height*Float(col)
                        boardVisual[row][col] = chessCubeEntity
                        if let chessPiece = squareModel.chessPiece {
                            let chessPieceEntity = createChessPieceEntity(chessPiece: chessPiece)
                            chessCubeEntity.addChild(chessPieceEntity)
                        }
                    }
                    
                }
            }
        }
    }
    
    func moveChessPieceEntity(chessPiece: ChessPiece) {
        
    }
    func createChessPieceEntity(chessPiece: ChessPiece) -> Entity{
        var newModelEntity: ModelEntity
        
        switch chessPiece.pieceType {
        case .pawn:
            newModelEntity = ModelEntity(mesh: MeshResource.generateCylinder(height: 0.2, radius: 0.03))
        case .knight:
            newModelEntity = ModelEntity(mesh: MeshResource.generateCylinder(height: 0.3, radius: 0.03))
        case .bishop:
            newModelEntity = ModelEntity(mesh: MeshResource.generateCylinder(height: 0.3, radius: 0.03))
        case .rook:
            newModelEntity = ModelEntity(mesh: MeshResource.generateCylinder(height: 0.4, radius: 0.03))
        case .king:
            newModelEntity = ModelEntity(mesh: MeshResource.generateCylinder(height: 0.5, radius: 0.03))
        case .queen:
            newModelEntity = ModelEntity(mesh: MeshResource.generateCylinder(height: 0.5, radius: 0.03))
        }
        let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: self.width, height: self.height, depth: self.depth)])
        newModelEntity.components.set(collisionComponent)
        newModelEntity.components.set(InputTargetComponent())

        newModelEntity.model?.materials = [SimpleMaterial(color: chessPiece.color == .black ? .black : .white, isMetallic: false)]
        newModelEntity.name = chessPiece.toString()
        
        return newModelEntity
    }

}
