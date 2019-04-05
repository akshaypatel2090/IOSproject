//
//  ScenePresentationDelegate.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import Foundation
import SpriteKit

protocol ScenePresentationDelegate {
    func shouldDismissScene(_ scene: SKScene) -> Void
}
