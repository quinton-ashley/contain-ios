//
//  Paddle.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import "Paddle.h"

@implementation Paddle

+ (id)newPaddleWithPath:(CGPathRef)path withRadius:(CGFloat)radius {
  Paddle *paddle = [Paddle spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(radius, radius)];
  paddle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
  paddle.physicsBody.categoryBitMask = 0x1 << 1;
  paddle.physicsBody.collisionBitMask = 0x1 << 10;
  paddle.physicsBody.contactTestBitMask = 0x1 << 0;
  return paddle;
}

@end
