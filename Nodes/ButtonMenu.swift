//
//  ButtonMenu.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import SpriteKit

class ButtonMenu: ButtonNode {
    
    lazy var label: SKLabelNode = {
        let node = SKLabelNode(text: self.title)
        
        node.verticalAlignmentMode = .center
        node.fontName = "MarkerFelt-Wide"
        node.zPosition = 5
        node.fontColor = Mode.Colors.text
        
        return node
    }()
    
    override init(title: String, size: CGSize, action: @escaping ButtonAction) {
        super.init(title: title, size: size, action: action)
        
        addChild(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
}
