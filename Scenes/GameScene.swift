//
//  GameScene.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum GameType {
    case onePlayer
    case twoPlayer
}

internal struct Board {
    static let pieceSize = CGSize(width: 100.0, height: 100.0)
    static let dimension = 3
}

class GameScene: SKScene {
    lazy var boardNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "board3")
        node.position = CGPoint(x: 0.0, y: 0.0)
        node.zPosition = -1
        node.isUserInteractionEnabled = false
        return node
    }()
    
    // could refactor, hide these in a different layer... button node layer
    lazy var quitButton: ButtonGame = {
        let title = NSLocalizedString("Exit", comment: "Exit")
        let size = CGSize(width: 84, height: 34)
        let action = self.quitGameScene
        let button = ButtonGame(title: title, size: size, action: action)
        
        return button
    }()
    
    lazy var restartButton: ButtonGame = {
        let title = NSLocalizedString("Restart", comment: "Restart")
        let size = CGSize(width: 84, height: 34)
        let action = self.restartGameScene
        let button = ButtonGame(title: title, size: size, action: action)
        
        return button
    }()
    
    lazy var moveLabel: SKLabelNode = {
        let node = SKLabelNode(text: "")
        node.fontName = Mode.Font.piece.name
        node.fontSize = CGFloat(Mode.Font.piece.size)
        
        return node
    }()
    
    // seems like you want a player state and computer state?
    // or should player X and O be configured as different opponent types?
    
    lazy var onePlayerStates: [GKState] = {
        let states = [
            SelectNextPlayerState(scene: self),
            PlayerXTurnState(scene: self, isComputerPlayer: false),
            PlayerOTurnState(scene: self, isComputerPlayer: true),
            CheckBoardState(scene: self),
            GameOverState(scene: self)
        ]
        
        return states
    }()
    
    lazy var twoPlayerStates: [GKState] = {
        let states = [
            SelectNextPlayerState(scene: self),
            PlayerXTurnState(scene: self, isComputerPlayer: false),
            PlayerOTurnState(scene: self, isComputerPlayer: false),
            CheckBoardState(scene: self),
            GameOverState(scene: self)
        ]
        
        return states
    }()
    
    lazy var gameStateMachine: InPlayStateMachine = {
        let states = (self.type == .onePlayer) ? self.onePlayerStates : self.twoPlayerStates
        let machine = InPlayStateMachine(states: states)
        return machine
    }()
    
    lazy var strategist: GKMinmaxStrategist = {
        let strategist = GKMinmaxStrategist()
        strategist.gameModel = self.model
        strategist.maxLookAheadDepth = 3
        strategist.randomSource = GKMersenneTwisterRandomSource()
        
        return strategist
    }()
    
    var presentationDelegate: ScenePresentationDelegate?
    
    fileprivate(set) var model: T3Model
    
    let playerX: T3Player
    let playerO: T3Player
    let type: GameType
    
    init(size: CGSize, type: GameType) {
        self.type = type
        
        // should the state machine own these?
        // the AI computer state needs to manipulate model
        // the model needs to track activePlayer...
        self.playerX = T3Player(playerId: 1, piece: .x)
        self.playerO = T3Player(playerId: 2, piece: .o)
        self.model = T3Model(players: [playerO, playerX])
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = Mode.Colors.background
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -30.0)
        
        self.addChild(boardNode)
        self.setupEmptyGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}

extension GameScene {
    func handleUIEventOn(_ node: SKNode) {
        guard let node = node as? PositionNode else { return }
        guard node.children.count == 0 else { return }
        guard let player = model.activePlayer as? T3Player else { return }
        
        let column = node.column
        let row = node.row
        let index = column + row * model.board.rows
        
        let piece = player.piece
        let move = T3Move(index: index, piece: piece)
        
        makeMoveForActivePlayer(move)
    }
    
    func makeMoveForActivePlayer(_ move: GKGameModelUpdate) {
        guard let move = move as? T3Move else { return }
        
        let column = move.index % model.board.rows
        let row = move.index / model.board.rows
        
        self.placePiece(move.piece, row: row, column: column)
        
        model.apply(move)
        gameStateMachine.enter(CheckBoardState.self)
    }
    
    func wiggleNodeAt(_ row: Int, column: Int) {
        let node = self.nodeAt(row, column: column)
        
        let wiggleInX = SKAction.scaleX(to: 1.0, duration: 0.2)
        let wiggleOutX = SKAction.scaleX(to: 1.2, duration: 0.2)
        
        let wiggleInY = SKAction.scaleY(to: 1.0, duration: 0.2)
        let wiggleOutY = SKAction.scaleY(to: 1.2, duration: 0.2)
        
        let wiggleX = SKAction.sequence([wiggleInX, wiggleOutX])
        let wiggleY = SKAction.sequence([wiggleInY, wiggleOutY])
        
        let wiggle = SKAction.group([wiggleX, wiggleY])
        let wiggleRepeat = SKAction.repeatForever(wiggle)
        
        node.run(wiggleRepeat, withKey: "wiggleRepeat")
    }
    
    func animateNodesOffScreen() {
        for child in self.children {
            if let positionNode = child as? PositionNode {
                for child in positionNode.children {
                    if child is GlyphNode {
                        child.physicsBody?.affectedByGravity = true
                        
                        child.physicsBody?.applyTorque(0.32)
                        child.physicsBody?.applyAngularImpulse(0.0001)
                    }
                }
            }
        }
    }
}
