//
//  ChessModel.swift
//  Chess
//
//  Created by Gabriel Weinbrenner on 1/19/24.
//

import Foundation

class ChessModel: ObservableObject {
    
    @Published var boardModels: [BoardModel]
    @Published var currentBoardModel: BoardModel?
    
    init() {
        boardModels = [
            BoardModel(),
            BoardModel(),
            BoardModel()
        ]
        currentBoardModel = nil
    }
    
    func getBoardModels() -> [BoardModel] {
        return boardModels
    }
    
    func getBoardModels(id: UUID) -> BoardModel? {
        for boardModel in self.boardModels {
            if boardModel.id == id {
                return boardModel
            }
        }
        return nil
    }
    
    func getRandomBoard() -> BoardModel {
        return boardModels[Int.random(in: 0..<boardModels.count)]
    }
    
    func getCurrentBoardModel() -> BoardModel? {
        return self.currentBoardModel ?? nil
    }
    
    func setCurrentBoardModel(id: UUID) throws{
        for boardModel in self.boardModels {
            if boardModel.id == id {
                self.currentBoardModel = boardModel
            }
        }
        throw ChessModelError.runtimeError("No ID Found")
    }
    
    func setCurrentBoardModel(boardModel: BoardModel) {
        self.currentBoardModel = boardModel
    }
    
    
    enum ChessModelError: Error {
        case runtimeError(String)
    }
}