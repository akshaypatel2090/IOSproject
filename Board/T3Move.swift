//
//  T3Move.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import GameplayKit

class T3Move: NSObject, GKGameModelUpdate {
    
    internal(set) var value: Int = 0
    
    fileprivate(set) var piece: TTTPiece
    fileprivate(set) var index: Int
    
    required init(index: Int, piece: TTTPiece) {
        self.index = index
        self.piece = piece
    }
}

extension T3Move {
    override var description: String {
        return "index: \(index), value: \(value)"
    }
}
