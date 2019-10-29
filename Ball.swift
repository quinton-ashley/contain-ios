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
	init(radius: CGFloat, position: CGPoint, speed: CGFloat) {
		let texture = SKTexture(imageNamed: "ball");
		super.init(texture: texture, color: SKColor.white, size: CGSize(width: radius, height: radius));
		self.physicsBody = SKPhysicsBody(circleOfRadius: radius);
		let velX = CGFloat(arc4random_uniform(UInt32(speed / 2)));
		let velY = CGFloat(speed - CGFloat(velX));
		let quadrantChance = arc4random_uniform(100)
		if quadrantChance <= 25 {
			self.physicsBody?.velocity = CGVector(dx: velX, dy: velY);
		} else if (quadrantChance <= 50) {
			self.physicsBody?.velocity = CGVector(dx: -velX, dy: CGFloat(velY));
		} else if (quadrantChance <= 75) {
			self.physicsBody?.velocity = CGVector(dx: -velX, dy: -velY);
		} else {
			self.physicsBody?.velocity = CGVector(dx: velX, dy: -velY);
		}

		self.physicsBody?.friction = 0
		self.physicsBody?.restitution = 1
		self.physicsBody?.linearDamping = 0
		self.position = position
		self.physicsBody?.categoryBitMask = 0x1 << 0
		self.physicsBody?.collisionBitMask = 0x1 << 10
		self.physicsBody?.contactTestBitMask = 0x1 << 1 | 0x1 << 2
	}
	
	init(radius: CGFloat, position: CGPoint, vector: CGVector) {
		let texture = SKTexture(imageNamed: "ball");
		super.init(texture: texture, color: SKColor.white, size: CGSize(width: radius, height: radius));
		self.physicsBody = SKPhysicsBody(circleOfRadius: radius);
		self.physicsBody?.velocity = vector;
		self.physicsBody?.friction = 0;
		self.physicsBody?.restitution = 1;
		self.physicsBody?.linearDamping = 0;
		self.position = position;
		self.physicsBody?.categoryBitMask = 0x1 << 0;
		self.physicsBody?.collisionBitMask = 0x1 << 10;
		self.physicsBody?.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
	}
	
	init() {
		let texture = SKTexture(imageNamed: "ball");
		let radius = 20;
		super.init(texture: texture, color: SKColor.white, size: CGSize(width: radius, height: radius));
	}
	
  required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
