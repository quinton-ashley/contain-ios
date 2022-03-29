//
//  Paddle.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//
import SpriteKit

class Paddle : SKSpriteNode {
	init(radius: CGFloat) {
		super.init(texture: SKTexture(imageNamed: "paddle"), color: SKColor.clear, size: CGSize(width: radius*2, height: radius*2));
		alpha = 1;
		physicsBody = SKPhysicsBody(circleOfRadius: radius);
		physicsBody?.categoryBitMask = 0x1 << 1;
		physicsBody?.collisionBitMask = 0x1 << 10;
		physicsBody?.contactTestBitMask = 0x1 << 0;
		physicsBody?.usesPreciseCollisionDetection = true;
	}
	
  required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
