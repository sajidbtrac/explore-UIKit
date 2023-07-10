//
//  GameScene.swift
//  Project23
//
//  Created by Sajid Shanta on 4/7/23.
//

import AVFoundation
import SpriteKit

enum ForceBomb {
    case never, always, random
}

class GameScene: SKScene {
    var gameScore: SKLabelNode!
    
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var liveImeges = [SKSpriteNode]()
    var lives = 3
    
    var activeSliceBackground: SKShapeNode!
    var activeSliceForeground: SKShapeNode!
    
    var activeSlicePoints = [CGPoint]()
    
    var isSwoosSoundActive = false
    
    var activeEnemies = [SKSpriteNode]()
    
    var bombSoundEffect: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        //background image
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        addChild(background)
        
        //setup gravity -6 insted of default -9.8 and reduce the speed
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
        
        createScore()
        createLive(totalLive: 3)
        createSlice()
    }
    
    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        gameScore.position = CGPoint(x: 8, y: 8)
        score = 0
    }
    
    func createLive(totalLive: Int) {
        for i in 0..<totalLive {
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            spriteNode.position = CGPoint(x: 834+(i*70), y: 720)
            addChild(spriteNode)
            liveImeges.append(spriteNode)
        }
    }
    
    func createSlice() {
        activeSliceBackground = SKShapeNode()
        activeSliceBackground.zPosition = 2
        activeSliceBackground.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1) // yellow
        activeSliceBackground.lineWidth = 9
        addChild(activeSliceBackground)
        
        activeSliceForeground = SKShapeNode()
        activeSliceForeground.zPosition = 3
        activeSliceBackground.strokeColor = UIColor.white
        activeSliceForeground.lineWidth = 5
        addChild(activeSliceForeground)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        
        redrawActiveSlice()
        
        if !isSwoosSoundActive {
            palySwooshSound()
        }
    }
    
    func palySwooshSound() {
        isSwoosSoundActive = true
        
        let soundName = "swoosh\(Int.random(in: 1...3)).caf"
        
        let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        
        run(swooshSound) { [weak self] in
            self?.isSwoosSoundActive = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBackground.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceForeground.run(SKAction.fadeOut(withDuration: 0.25))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        activeSlicePoints.removeAll(keepingCapacity: true)
        
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        
        redrawActiveSlice()
        
        activeSliceBackground.removeAllActions()
        activeSliceForeground.removeAllActions()
        
        activeSliceBackground.alpha = 1
        activeSliceForeground.alpha = 1
    }
    
    func redrawActiveSlice() {
        if activeSlicePoints.count < 2 { // avoid small slice
            activeSliceBackground.path = nil
            activeSliceForeground.path = nil
            return
        }
        
        if activeSlicePoints.count > 12 {
            activeSlicePoints.removeFirst(activeSlicePoints.count - 12) // so that, max slice size is 12
        }
        
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])
        
        for i in 1..<activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }
        
        activeSliceBackground.path = path.cgPath
        activeSliceForeground.path = path.cgPath
    }
    
    func createEnemy(forceBomb: ForceBomb = .random) {
        let enemy: SKSpriteNode
        
        var anemyType = Int.random(in: 0...6)
        
        if forceBomb == .always {
            anemyType = 0 // bomb
        } else if forceBomb == .never {
            anemyType = 1 //penguin
        }
        
        if anemyType == 0 {
            // create bomb
            enemy = SKSpriteNode()
            enemy.zPosition = 1 //ahead of penguin
            enemy.name = "bombContainer"
            
            let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
            bombImage.name = "bomb"
            enemy.addChild(bombImage)
            
            // stop prevoius sound (if any)
            if bombSoundEffect != nil {
                bombSoundEffect?.stop()
                bombSoundEffect = nil
            }
            
            if let path = Bundle.main.url(forResource: "sliceBombFuse", withExtension: "caf") {
                if let sound = try? AVAudioPlayer(contentsOf: path) {
                    bombSoundEffect = sound
                    sound.play()
                }
            }
            
            if let emitter =  SKEmitterNode(fileNamed: "sliceFuse") {
                emitter.position = CGPoint(x: 76, y: 64)
                enemy.addChild(emitter)
            }
        } else {
            //create penguin
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
            enemy.name = "enemy"
        }
        
        let randomPosition = CGPoint(x: Int.random(in: 64...960), y: -128)
        enemy.position = randomPosition
        
        let randomAngularVelocity = CGFloat.random(in: -3...3)
        let randomXVelocity: Int
        
        if randomPosition.x < 256 { // extreme left
            randomXVelocity = Int.random(in: 8...15) // high
        } else if randomPosition.x < 512 {
            randomXVelocity = Int.random(in: 3...5)
        } else if randomPosition.x < 768 {
            randomXVelocity = -Int.random(in: 3...5)
        } else {
            randomXVelocity = -Int.random(in: 8...15)
        }
        
        let randomYVelocity = Int.random(in: 24...32)
        
        enemy.physicsBody = SKPhysicsBody(circleOfRadius:  64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity*40, dy: randomYVelocity*40)
        enemy.physicsBody?.angularVelocity =  randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0
        
        //TODO: position code
        
        addChild(enemy)
        activeEnemies.append(enemy )
    }
    
    override func update(_ currentTime: TimeInterval) {
        var bombCount = 0
        
        for node in activeEnemies {
            if node.name == "bombContainer" {
                bombCount += 1
                break
            }
        }
        
        if bombCount == 0 {
            // no bomb - stop the fuse sound
            bombSoundEffect?.stop()
            bombSoundEffect = nil
        }
    }
}
