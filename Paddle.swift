//
//  Paddle.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//
import SpriteKit

class Paddle : SKSpriteNode {
	init(path: CGPath?, radius: CGFloat) {
		let texture = SKTexture(imageNamed: "ball");
		super.init(texture: texture, color: SKColor.white, size: CGSize(width: radius, height: radius));
		self.physicsBody = SKPhysicsBody(circleOfRadius: radius);
		self.physicsBody?.categoryBitMask = 0x1 << 1;
		self.physicsBody?.collisionBitMask = 0x1 << 10;
		self.physicsBody?.contactTestBitMask = 0x1 << 0;
	}
	
  required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
