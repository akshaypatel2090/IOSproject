//
//  InPlayStateMachine.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import GameplayKit

class InPlayStateMachine: GKStateMachine {
    
    var lastPlayerState: GKState.Type?
    
    fileprivate(set) var moveCount: Int = 0
    
    func resetToInitialState() {
        self.moveCount = 0
        self.lastPlayerState = nil
        
        self.enter(SelectNextPlayerState.self)
    }
    
    var glyphForState: String {
        return currentState is PlayerXTurnState ? "X" : "O"
    }
    
    var glyphColorForState: Color {
        let colorForX = Color.ColorAsHex("#ff0000")
        let colorForO = Color.ColorAsHex("#00FCDB")
        
        return currentState is PlayerXTurnState ? colorForX : colorForO
    }
}
