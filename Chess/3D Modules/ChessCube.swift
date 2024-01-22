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

class ChessCube {
    var height: Float
    var width: Float
    var depth: Float
    var squareModel: SquareModel
    var selectionModel: SelectionModel
    var chessCubeEntity: Entity?
    
    init(height: Float, width: Float, depth: Float, squareModel: SquareModel, selectionModel: SelectionModel) {
        self.height = height
        self.width = width
        self.depth = depth
        self.squareModel = squareModel
        self.selectionModel = selectionModel
        self.chessCubeEntity = createBoardCube()
    }
    
    func createBoardCube() -> Entity? {
        let cubeMesh = MeshResource.generateBox(width: self.width, height: self.height, depth: self.depth)
        // Split Faces
        
    //        var grassSide = UnlitMaterial()
    //        var dirt = UnlitMaterial()
    //        var grassTop = UnlitMaterial()
    //
    //        do {
    //            let grassTexture = try TextureResource.load(named: "grass_block_side.png")
    //            grassSide.baseColor = MaterialColorParameter.texture(grassTexture)
    //
    //            let dirtTexture = try TextureResource.load(named: "dirt.png")
    //            dirt.baseColor = MaterialColorParameter.texture(dirtTexture)
    //
    //            let grass = try TextureResource.load(named: "grass_top.png")
    //            grassTop.baseColor = MaterialColorParameter.texture(grass)
    //
    //        } catch {
    //            print("Failed to load texture:", error)
    //            return nil
    //        }
    //
        let cubeEntity = ModelEntity(mesh: cubeMesh)
        let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: self.width, height: self.height, depth: self.depth)])
        cubeEntity.components.set(collisionComponent)
        cubeEntity.components.set(InputTargetComponent())
        var material = SimpleMaterial()
        if(squareModel.file == "a" && squareModel.rank == "7") {
            print("selectionMOdel: a7")
            print(selectionModel.firstSelection)
        }
        if selectionModel.contains(squareModel: squareModel) {
            material.color = .init(tint: .black)
        } else {
            material.color = .init(tint: squareModel.color == .black ? BLACK_SQUARE_CUBE : WHITE_SQUARE_CUBE)
        }
        cubeEntity.model?.materials = [material]
    //        cubeEntity.model?.materials = [grassSide, grassTop, grassSide, dirt, grassSide, grassSide]
        cubeEntity.name = "\(squareModel.file)\(squareModel.rank)"
        return cubeEntity
    }

    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
    
    
    
    
}
