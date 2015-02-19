//
//  GameScene.swift
//  Flappy Bird
//
//  Created by George Lo on 2/6/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var birdNode: SKSpriteNode?
    
    let verticalPipeGap = 100
    let pipeTexture1: SKTexture!
    let pipeTexture2: SKTexture!
    let moveAndRemovePipes: SKAction!
    
    var pipes: SKNode!
    
    var score: Int = 0
    let scoreLabel: SKLabelNode!
    
    // 0000 0001
    let birdCategory = UInt32(1 << 0)  //0001
    let worldCategory = UInt32(1 << 1) // 0010
    let pipeCategory = UInt32(1 << 2) //0100
    let scoreCategory = UInt32(1 << 3) // 1000
    
    var canRestart = false
    
    let moving: SKNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        canRestart = false
        
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(fontNamed: "Avenir")
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), 100)
        scoreLabel.zPosition = 100
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
        
        moving = SKNode()
        self.addChild(moving)
        
        pipes = SKNode()
        moving.addChild(pipes)
        
        // Background color
        let skyBlueColor = SKColor(red: 135.0/255, green: 206.0/255, blue: 250.0/255, alpha: 1)
        self.backgroundColor = skyBlueColor
        
        // Bird Animation
        let birdTexture1 = SKTexture(image: UIImage(named: "Bird1")!)
        birdTexture1.filteringMode = SKTextureFilteringMode.Nearest
        let birdTexture2 = SKTexture(image: UIImage(named: "Bird2")!)
        birdTexture2.filteringMode = SKTextureFilteringMode.Nearest
        let flappingAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.2))
        
        
        /*
        for var i = 0; i <= numOfGrounds; i++ {
        }*/
        
        
        // Ground
        let groundTexture = SKTexture(image: UIImage(named: "Ground")!)
        groundTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        let moveGroundSprite = SKAction.moveByX(-groundTexture.size().width, y: 0, duration: Double(0.02 * groundTexture.size().width*2))
        let resetGroundSprite = SKAction.moveByX(groundTexture.size().width, y: 0, duration: 0)
        let moveGroundForever = SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite]))
        
        let numOfGrounds: Int = Int(self.frame.size.width / groundTexture.size().width) + 1
        for i in 0...numOfGrounds {
            let sprite = SKSpriteNode(texture: groundTexture)
            sprite.setScale(2.0)
            sprite.position = CGPointMake(CGFloat(i) * sprite.size.width, sprite.size.height / 2)
            sprite.runAction(moveGroundForever)
            moving.addChild(sprite)
        }
        
        // Skyline
        let skylineTexture = SKTexture(image: UIImage(named: "Skyline")!)
        skylineTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        let moveSkylineSprite = SKAction.moveByX(-skylineTexture.size().width, y: 0, duration: Double(0.1 * skylineTexture.size().width*2))
        let resetSkylineSprite = SKAction.moveByX(skylineTexture.size().width, y: 0, duration: 0)
        let moveSkylineForever = SKAction.repeatActionForever(SKAction.sequence([moveSkylineSprite, resetSkylineSprite]))
        
        let numOfSkylines: Int = Int(self.frame.size.width / skylineTexture.size().width) + 1
        for i in 0...numOfSkylines {
            let sprite = SKSpriteNode(texture: skylineTexture)
            sprite.setScale(2.0)
            sprite.zPosition = -20
            sprite.position = CGPointMake(CGFloat(i) * sprite.size.width, sprite.size.height / 2 + groundTexture.size().height * 2)
            sprite.runAction(moveSkylineForever)
            moving.addChild(sprite)
        }
        
        // Bird
        birdNode = SKSpriteNode(texture: birdTexture1)
        birdNode?.setScale(2.0)
        birdNode?.position = CGPointMake(self.frame.width / 4, CGRectGetMidY(self.frame))
        birdNode?.runAction(flappingAnimation)
        
        birdNode?.physicsBody = SKPhysicsBody(circleOfRadius: birdNode!.frame.height / 2)
        birdNode?.physicsBody?.dynamic = true
        birdNode?.physicsBody?.allowsRotation = false
        
        birdNode?.physicsBody?.categoryBitMask = birdCategory
        birdNode?.physicsBody?.collisionBitMask = worldCategory | pipeCategory
        birdNode?.physicsBody?.contactTestBitMask = worldCategory | pipeCategory
        
        self.addChild(birdNode!)
        
        // Physics Body for ground
        let dummy = SKNode()
        dummy.position = CGPointMake(0, groundTexture.size().height)
        dummy.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width, groundTexture.size().height * 2))
        dummy.physicsBody?.dynamic = false
        dummy.physicsBody?.categoryBitMask = worldCategory
        self.addChild(dummy)
        
        // Load Pipe Images to SKTexture
        pipeTexture1 = SKTexture(imageNamed: "Pipe1")
        pipeTexture1.filteringMode = SKTextureFilteringMode.Nearest
        pipeTexture2 = SKTexture(imageNamed: "Pipe2")
        pipeTexture2.filteringMode = SKTextureFilteringMode.Nearest
        
        let distanceToMove = self.frame.width + 2 * pipeTexture1.size().width
        let movePipes = SKAction.moveByX(-distanceToMove, y: 0, duration: Double(0.01 * distanceToMove))
        let removePipes = SKAction.removeFromParent()
        moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        let spawn = SKAction.runBlock(self.spawnPipe)
        let delay = SKAction.waitForDuration(2.0)
        let spawnAndDelayForever = SKAction.repeatActionForever(SKAction.sequence([spawn, delay]))
        self.runAction(spawnAndDelayForever)
    }
    
    func spawnPipe() {
        let pipePair = SKNode()
        pipePair.position = CGPointMake(self.frame.size.width + pipeTexture1.size().width, 0)
        pipePair.zPosition = -10
        
        let y = arc4random() % UInt32(self.frame.size.height / 3.0)
        
        // Generating the first pipe
        let pipe1 = SKSpriteNode(texture: pipeTexture1)
        pipe1.setScale(2.0)
        pipe1.position = CGPointMake(0, CGFloat(y))
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        pipe1.physicsBody?.dynamic = false
        pipe1.physicsBody?.categoryBitMask = pipeCategory
        pipe1.physicsBody?.contactTestBitMask = birdCategory
        pipePair.addChild(pipe1)
        
        // Generating the second pipe
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        pipe2.setScale(2.0)
        pipe2.position = CGPointMake(0, CGFloat(y) + pipe1.size.height + CGFloat(verticalPipeGap))
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        pipe2.physicsBody?.dynamic = false
        pipe2.physicsBody?.categoryBitMask = pipeCategory
        pipe2.physicsBody?.contactTestBitMask = birdCategory
        pipePair.addChild(pipe2)
        
        let contactNode = SKNode()
        contactNode.position = CGPointMake(pipe1.size.width + birdNode!.size.width / 2, CGRectGetMidY(self.frame))
        contactNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipe2.size.width, self.frame.size.height))
        contactNode.physicsBody?.dynamic = false
        contactNode.physicsBody?.categoryBitMask = scoreCategory
        contactNode.physicsBody?.contactTestBitMask = birdCategory
        pipePair.addChild(contactNode)
        
        pipePair.runAction(moveAndRemovePipes)
        
        pipes.addChild(pipePair)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if moving.speed > 0 {
            // Apply physics to make the bird fly
            birdNode?.physicsBody?.velocity = CGVectorMake(0, 0)
            birdNode?.physicsBody?.applyImpulse(CGVectorMake(0, 4))
        } else if canRestart == true {
            resetGame()
        }
    }
    
    func resetGame() {
        birdNode!.position = CGPointMake(self.frame.width / 4, CGRectGetMidY(self.frame))
        birdNode!.physicsBody?.velocity = CGVectorMake(0, 0)
        birdNode!.physicsBody?.collisionBitMask = worldCategory | pipeCategory
        birdNode?.speed = 1.0
        birdNode?.zRotation = 0.0
        
        canRestart = false
        
        pipes.removeAllChildren()
        
        moving.speed = 1
        
        score = 0
        scoreLabel.text = "\(score)"
    }
    
    func clamp(#min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        if value > max {
            return max
        } else if value < min {
            return min
        }
        return value
    }
    
    override func update(currentTime: CFTimeInterval) {
        if moving.speed > 0 {
            // Make the bird facing upward/downward
            birdNode!.zRotation = self.clamp(min: -1, max: 0.8, value: (birdNode!.physicsBody!.velocity.dy * (birdNode!.physicsBody!.velocity.dy < 0 ? 0.003 : 0.001)))
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if moving.speed > 0 {
            if contact.bodyA.categoryBitMask & scoreCategory == scoreCategory || contact.bodyB.categoryBitMask & scoreCategory == scoreCategory {
                score++
                scoreLabel.text = "\(score)"
            } else {
                moving.speed = 0
                // Telling user the game has ended
                self.removeActionForKey("flash")
                self.runAction(SKAction.sequence([
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.runBlock({
                            self.backgroundColor = UIColor.redColor()
                        }),
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({
                            self.backgroundColor = SKColor(red: 135.0/255, green: 206.0/255, blue: 250.0/255, alpha: 1)
                        }),
                        SKAction.waitForDuration(0.05)
                        ]), count: 4), SKAction.runBlock({
                            self.canRestart = true
                        })
                    ]))
            }
        }
    }
}
