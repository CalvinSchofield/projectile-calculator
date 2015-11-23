//
//  GameScene.swift
//  Physics Visualizations
//
//  Created by Calvin Schofield on 11/13/15.
//  Copyright (c) 2015 Calvin Schofield. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor.whiteColor()
        
        physicsWorld.gravity = CGVectorMake(0, -9.8)
        
        
        //Angle could be selected by a UISlider that goes from 0 to 90 degrees. At 90 degrees, the incline will dissapear
        let angle = CGFloat(20)
        
        //The mass could be determined by a text field
        let mass = CGFloat(20.2)
        
        setup(((angle * CGFloat(M_PI)) / 180.0), mass: mass)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    func setup(angle: CGFloat, mass: CGFloat) {
        
        let ground = SKShapeNode(rectOfSize: CGSize(width: 1000, height: 20))
        
        ground.fillColor = SKColor.grayColor()
        
        ground.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 100)
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1000, height: 20))
        
        if let physics = ground.physicsBody {
            
            //Can change the coefficient of between the ground and the block. (between 0.0 and 1.0)
            physics.friction = 0.2
            
            physics.dynamic = false
            
            physics.affectedByGravity = false
            
            physics.allowsRotation = false
            
        }
        
        ground.zRotation = CGFloat(angle)
        
        addChild(ground)
        
        
        let brick = SKShapeNode(rectOfSize: CGSize(width: 100, height: 50))
        
        brick.fillColor = SKColor.blackColor()
        
        brick.position = CGPoint(x: frame.width * 0.6, y: frame.height * 0.8)
        
        brick.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 100, height: 50))
        
        if let physics = brick.physicsBody {
            
            physics.mass = CGFloat(mass)
            
            physics.dynamic = true
            
            physics.affectedByGravity = true
            
            physics.allowsRotation = true
            
        }
        
        addChild(brick)
        
        
        let normalForceLabel = SKLabelNode()
        
        normalForceLabel.fontColor = SKColor.blackColor()
        
        normalForceLabel.position = CGPoint(x: frame.width / 2, y: frame.height * 0.8)
        
        normalForceLabel.text = "Fn: " + String(findNormalForce(angle, mass: mass))
        
        addChild(normalForceLabel)
        
        
        let gravityForceLabel = SKLabelNode()
        
        gravityForceLabel.fontColor = SKColor.blackColor()
        
        gravityForceLabel.position = CGPoint(x: normalForceLabel.position.x, y: normalForceLabel.position.y - 100)
        
        gravityForceLabel.text = "Fg: " + String(findGravityX(angle, mass: mass))
        
        addChild(gravityForceLabel)
        
        
        let gravityLabel = SKLabelNode()
        
        gravityLabel.fontColor = SKColor.blackColor()
        
        gravityLabel.position = CGPoint(x: normalForceLabel.position.x, y: normalForceLabel.position.y * 0.05)
        
        gravityLabel.text = "Gravity: " + String(mass * 9.8)
        
        addChild(gravityLabel)
        
    }
    
    
    func findGravityX(angle: CGFloat, mass: CGFloat) -> CGFloat {
        
        return (mass * 9.8) * sin(angle)
        
    }
    
    
    func findNormalForce(angle: CGFloat, mass: CGFloat) -> CGFloat {
        
        return (mass * 9.8) * cos(angle)
        
    }
    
}
