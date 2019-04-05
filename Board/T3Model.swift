//
//  T3Model.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import GameplayKit

class T3Model: NSObject {
    private(set) var players: [GKGameModelPlayer]?
    var activePlayer: GKGameModelPlayer?
    
    fileprivate(set) var board: T3Board
    
    init(players: [GKGameModelPlayer]?) {
        self.players = players
        self.board = T3Board()
        super.init()
    }
    
    func resetGameBoard() {
        self.board = T3Board()
        self.activePlayer = nil
    }
}

extension T3Model: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let model = T3Model(players: players)
        model.setGameModel(self)
        return model
    }
}

extension T3Model {
    fileprivate func nextPlayerAfter(_ player: GKGameModelPlayer?) -> GKGameModelPlayer? {
        guard let players = players as? [T3Player] else { return nil }
        guard let player = player as? T3Player else { return nil }
        
        assert(players.count == 2)
        
        let playerX = players.filter { $0.piece == TTTPiece.x }.first!
        let playerO = players.filter { $0.piece == TTTPiece.o }.first!
        
        return (player == playerX) ? playerO : playerX
    }
}

extension T3Model: GKGameModel {
    func setGameModel(_ model: GKGameModel) {
        guard let model = model as? T3Model else { return }
        
        self.board = model.board
        self.activePlayer = model.activePlayer
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        guard let player = player as? T3Player else { return nil }
        
        let indexed = board.positions.enumerated().map { return (index: $0, marker: $1) }
        let empty = indexed.filter { (_, marker) -> Bool in
            return (marker.position == .empty) ? true : false
        }
        
        let moves = empty.map { return T3Move(index: $0.index, piece: player.piece)}
        return (moves.count > 0) ? moves: nil
    }
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        guard let move = gameModelUpdate as? T3Move else { return }
        
        self.board = board.afterMaking(move)
        self.activePlayer = nextPlayerAfter(activePlayer)
    }
    
    func score(for player: GKGameModelPlayer) -> Int {
        guard let player = player as? T3Player else { return 0 }
        let piece = player.piece
        
        let score = board.score(forPiece: piece)
        let opponent = (board.score(forPiece: piece.opposite) - 20) * -1
        let adjusted = score + opponent
        
        return adjusted
    }
}
