//
//  GameScene.swift
//  Project11
//
//  Created by BTSL.SAJID on 12/6/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let box = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        box.position = location
        addChild(box)
    }
}
