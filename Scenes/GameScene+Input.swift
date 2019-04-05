//
//  GameScene+Input.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import UIKit

extension GameScene {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if containsTouches(touches) {
            guard let touch = touches.first else { return }
            guard let scene = scene else { return }
            
            let touchPoint = touch.location(in: scene)
            let node = scene.atPoint(touchPoint)
            
            guard node is PositionNode else { return }
            
            self.handleUIEventOn(node)
        }
    }
    
    fileprivate func containsTouches(_ touches: Set<UITouch>) -> Bool {
        guard let scene = scene else { fatalError("Button must be used within a scene.") }
        
        return touches.contains { touch in
            let touchPoint = touch.location(in: scene)
            let touchedNode = scene.atPoint(touchPoint)
            return touchedNode === self || touchedNode.inParentHierarchy(self)
        }
    }
}
