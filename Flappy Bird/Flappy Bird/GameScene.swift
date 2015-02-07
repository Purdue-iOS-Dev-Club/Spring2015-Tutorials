//
//  GameScene.swift
//  Flappy Bird
//
//  Created by George Lo on 2/6/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var birdNode: SKSpriteNode?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        
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
            self.addChild(sprite)
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
            sprite.position = CGPointMake(CGFloat(i) * sprite.size.width, sprite.size.height / 2 + groundTexture.size().height * 2)
            sprite.runAction(moveSkylineForever)
            self.addChild(sprite)
        }
        
        // Bird
        birdNode = SKSpriteNode(texture: birdTexture1)
        birdNode?.setScale(2.0)
        birdNode?.position = CGPointMake(self.frame.width / 4, CGRectGetMidY(self.frame))
        birdNode?.runAction(flappingAnimation)
        
        birdNode?.physicsBody = SKPhysicsBody(circleOfRadius: birdNode!.frame.height / 2)
        birdNode?.physicsBody?.dynamic = true
        birdNode?.physicsBody?.allowsRotation = false
        
        self.addChild(birdNode!)
        
        let dummy = SKNode()
        dummy.position = CGPointMake(0, groundTexture.size().height)
        dummy.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width, groundTexture.size().height * 2))
        dummy.physicsBody?.dynamic = false
        self.addChild(dummy)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        birdNode?.physicsBody?.velocity = CGVectorMake(0, 0)
        birdNode?.physicsBody?.applyImpulse(CGVectorMake(0, 6))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
