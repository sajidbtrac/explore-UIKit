//
//  GameScene.swift
//  Project17
//
//  Created by BTSL.SAJID on 15/6/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starField = SKEmitterNode(fileNamed: "starfield")
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10) // we’re going to ask SpriteKit to simulate 10 seconds passing in the emitter, thus updating all the particles as if they were created 10 seconds ago. This will have the effect of filling our screen with star particles.
        addChild(starField)
        starField.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        score = 0
        
        //disabel gravety, cause we are in Space
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
