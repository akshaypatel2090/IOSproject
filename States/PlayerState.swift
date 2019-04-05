//
//  PlayerState.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import Foundation
import GameplayKit

class PlayerState: InPlayState {
    fileprivate let isComputerPlayer: Bool
    
    required init(scene: SKScene, isComputerPlayer: Bool = false) {
        self.isComputerPlayer = isComputerPlayer
        super.init(scene: scene)
    }
    
    required init(scene: SKScene) {
        self.isComputerPlayer = false
        super.init(scene: scene)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        if isComputerPlayer {
            guard let scene = scene as? GameScene else { return }
            guard let player = scene.model.activePlayer as? T3Player else { return }
            let glyph = player.piece.glyph
            
            let title = NSLocalizedString("Player \(glyph) is making a move...", comment: "")
            scene.moveLabel.text = title
            scene.moveLabel.fontColor = Mode.Colors.blue
            
            let delay = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                if let move = scene.strategist.bestMove(for: player) {
                    scene.makeMoveForActivePlayer(move)
                }
                else {
                    fatalError("no moves found...")
                }
            }
        }
        else {
            // if the player isn't artificial, the UI will transition
            // states when the user makes a move.
        }
    }
}

class PlayerOTurnState: PlayerState { }
class PlayerXTurnState: PlayerState { }
