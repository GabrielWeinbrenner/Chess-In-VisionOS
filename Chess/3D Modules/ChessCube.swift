//
//  ChessCube.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/21/24.
//

import Foundation
import RealityKit
import SwiftUI
let BLACK_SQUARE_CUBE: UIColor = UIColor(red: CGFloat(118.0/255.0), green: CGFloat(150.0/255.0), blue: CGFloat(86.0/255.0), alpha: 1)
let WHITE_SQUARE_CUBE: UIColor = UIColor(red: CGFloat(238.0/255.0), green: CGFloat(238.0/255.0), blue: CGFloat(210.0/255.0), alpha: 1)
let HIGHLIGHT_SQUARE_CUBE: UIColor = UIColor(red: CGFloat(68.0/255.0), green: CGFloat(112.0/255.0), blue: CGFloat(6.0/255.0), alpha: 1)

class ChessCube {
    var height: Float
    var width: Float
    var depth: Float
    var squareModel: SquareModel
    var selectionModel: SelectionModel
    var chessCubeEntity: ModelEntity?
    
    init(height: Float, width: Float, depth: Float, squareModel: SquareModel, selectionModel: SelectionModel) {
        self.height = height
        self.width = width
        self.depth = depth
        self.squareModel = squareModel
        self.selectionModel = selectionModel
        self.chessCubeEntity = createBoardCube()
    }
    
    func createBoardCube() -> ModelEntity? {
        // Split the faces
        let cubeMesh = MeshResource.generateBox(width: self.width, height: self.height, depth: self.depth, splitFaces: true)

        let cubeEntity = ModelEntity(mesh: cubeMesh)
        let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: self.width, height: self.height, depth: self.depth)])
        cubeEntity.components.set(collisionComponent)
        cubeEntity.components.set(InputTargetComponent())
        var material = SimpleMaterial()
        material.color = .init(tint: squareModel.color == .black ? BLACK_SQUARE_CUBE : WHITE_SQUARE_CUBE)
        var highlightMaterial = SimpleMaterial()
        if selectionModel.contains(squareModel: squareModel) {
            highlightMaterial.color = .init(tint: .black)
            cubeEntity.model?.materials = [material, highlightMaterial, material, material, material, material]
        } else if squareModel.availableMove {
            highlightMaterial.color = .init(tint: HIGHLIGHT_SQUARE_CUBE)
            cubeEntity.model?.materials = [material, highlightMaterial, material, material, material, material]
        } else {
            cubeEntity.model?.materials = [material, material, material, material, material, material]
        }
        cubeEntity.name = "\(squareModel.file)\(squareModel.rank)"
        return cubeEntity
    }

    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
    
    
    
    
}
