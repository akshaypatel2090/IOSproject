//
//  T3Player.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import GameplayKit

@objc class T3Player: NSObject, GKGameModelPlayer {
    
    fileprivate(set) var playerId: Int
    fileprivate(set) var piece: TTTPiece
    
    init(playerId: Int, piece: TTTPiece) {
        self.playerId = playerId
        self.piece = piece
        super.init()
    }
}
