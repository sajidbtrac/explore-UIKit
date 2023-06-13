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
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
//        let box = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
//        box.position = location
//        addChild(box)
        
        let ball = SKSpriteNode(imageNamed: "ballRed")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2)
        bouncer.physicsBody?.isDynamic = false //fix it's position (balss react/ bounce with it. but it's not react/ bounce
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        let slotBase = SKSpriteNode(imageNamed: isGood ? "slotBaseGood" : "slotBaseBad")
        slotBase.position = position
        addChild(slotBase)
        
        let slotGlow = SKSpriteNode(imageNamed: isGood ? "slotGlowGood" : "slotGlowBad")
        slotGlow.position = position
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
}
