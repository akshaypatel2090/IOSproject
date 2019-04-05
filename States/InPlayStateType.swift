//
//  InPlayStateType.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import Foundation
import SpriteKit
import GameplayKit

protocol InPlayStateType {
    unowned var scene: SKScene { get }
    var model: T3Model { get }
    
    init(scene: SKScene)
}

extension InPlayStateType where Self: GKState {
    var model: T3Model {
        guard let scene = scene as? GameScene else { fatalError() }
        return scene.model
    }
}

class InPlayState: GKState, InPlayStateType {
    fileprivate(set) unowned var scene: SKScene
    
    required init(scene: SKScene) {
        self.scene = scene
        super.init()
    }
}
