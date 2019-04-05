//
//  GameOverState.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import GameplayKit
import SpriteKit

class GameOverState: InPlayState {
    
    override func didEnter(from previousState: GKState?) {
        guard let scene = self.scene as? GameScene else { return }
        
        let board = scene.model.board
        
        if board.isWin(forPiece: .x) {
            let title = NSLocalizedString("Player X wins!", comment: "Player X wins!")
            scene.moveLabel.text = title
            scene.moveLabel.fontColor = Mode.Colors.red
        }
        else if board.isWin(forPiece: .o) {
            let title = NSLocalizedString("Player O wins!", comment: "Player O wins!")
            scene.moveLabel.text = title
            scene.moveLabel.fontColor = Mode.Colors.blue
        }
        else {
            let title = NSLocalizedString("It's a Draw!", comment: "It's a Draw!")
            scene.moveLabel.text = title
            scene.moveLabel.fontColor = Mode.Colors.blue
        }
        
        let title = NSLocalizedString("Again?", comment: "Again?")
        scene.restartButton.label.text = title
        
        guard let winningCombo = board.winningCombo() else { return }
        
        winningCombo.forEach { (index) in
            let column = index % board.rows
            let row = index / board.rows
            scene.wiggleNodeAt(row, column: column)
        }
    }
}
