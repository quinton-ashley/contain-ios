//  Converted to Swift 5.1 by Swiftify v5.1.30744 - https://objectivec2swift.com/
//
//  Ball.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//
import SpriteKit

class Ball: SKSpriteNode {
	init(radius: CGFloat, speed: CGFloat) {
		super.init(texture: SKTexture(imageNamed: "ball"), color: SKColor.clear, size: CGSize(width: radius*2, height: radius*2));
		alpha = 1;
		physicsBody = SKPhysicsBody(circleOfRadius: radius);
		let velX = CGFloat(arc4random_uniform(UInt32(speed / 2)));
		let velY = CGFloat(speed - CGFloat(velX));
		let quadrantChance = arc4random_uniform(100)
		if (quadrantChance <= 25) {
			physicsBody?.velocity = CGVector(dx: velX, dy: velY);
		} else if (quadrantChance <= 50) {
			physicsBody?.velocity = CGVector(dx: -velX, dy: CGFloat(velY));
		} else if (quadrantChance <= 75) {
			physicsBody?.velocity = CGVector(dx: -velX, dy: -velY);
		} else {
			physicsBody?.velocity = CGVector(dx: velX, dy: -velY);
		}

		physicsBody?.friction = 0;
		physicsBody?.restitution = 1;
		physicsBody?.linearDamping = 0;
		physicsBody?.categoryBitMask = 0x1 << 0;
		physicsBody?.collisionBitMask = 0x1 << 10;
		physicsBody?.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
		physicsBody?.usesPreciseCollisionDetection = true;
	}
	
	init(radius: CGFloat, vector: CGVector) {
		super.init(texture: SKTexture(imageNamed: "ball"), color: SKColor.clear, size: CGSize(width: radius*2, height: radius*2));
		physicsBody = SKPhysicsBody(circleOfRadius: radius);
		physicsBody?.velocity = vector;
		physicsBody?.friction = 0;
		physicsBody?.restitution = 1;
		physicsBody?.linearDamping = 0;
		physicsBody?.categoryBitMask = 0x1 << 0;
		physicsBody?.collisionBitMask = 0x1 << 10;
		physicsBody?.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
	}
	
  required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
