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
    var chessPieces: Entity
    init(boardModel: BoardModel) {
        boardVisual = Array(repeating: Array(repeating: Entity(), count: 8), count: 8)
        chessPieceVisual = []
        self.boardModel = boardModel
        if let chessPiecesEntity = try? ModelEntity.load(named: "ChessPiecesModel") {
            self.chessPieces = chessPiecesEntity
        } else {
            self.chessPieces = ModelEntity(mesh: MeshResource.generateBox(width: self.width*0.02, height: self.height*1.1, depth: self.depth*0.02))

        }
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
                            chessPieceEntity.position.y = depth/2
                            chessCubeEntity.addChild(chessPieceEntity)
                            chessPieceVisual.append(chessPieceEntity)
                        }
                    }
                    
                }
            }
        }
    }
    func changePosition(value: Point3D) {
//        if let boardEntity = self.boardEntity {
        self.boardEntity.position = .init(x: Float(value.x), y: Float(value.y), z: Float(value.z))
//        }
    }
    func moveChessPieceEntity(chessPiece: ChessPiece) {
        
    }
    func createChessPieceEntity(chessPiece: ChessPiece) -> Entity{
        var newEntity: Entity = Entity()
        let widthScale = Float(0.2)
        let depthScale = Float(0.2)
        let universalScale = Float(0.02)
        let entityName = chessPiece.pieceType.toString()
        if let pieceEntity: Entity = self.chessPieces.findEntity(named: entityName){
            newEntity = pieceEntity.clone(recursive: true)
            pieceEntity.transform.translation = .init(repeating: 0)
            let newScale: SIMD3<Float> = .init(x: widthScale*universalScale, y: depthScale*universalScale, z: depthScale*universalScale)
            newEntity.scale = newScale
            let collisionComponent = CollisionComponent(shapes: [.generateBox(size: .init(x: width, y: height, z: depth))])
            newEntity.components.set(collisionComponent)
            newEntity.components.set(InputTargetComponent())
        }
        var newEntityModel = newEntity.children[0] as! ModelEntity
        newEntityModel.model?.materials = [SimpleMaterial(color: chessPiece.color == .black ? .black : .white, isMetallic: false)]
        newEntityModel.name = chessPiece.toString()
        
        return newEntity
    }

}
