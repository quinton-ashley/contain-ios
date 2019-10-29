//
//  Ball.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import "Ball.h"

@implementation Ball

+ (id)newBallWithRadius:(CGFloat)radius position:(CGPoint)position speed:(CGFloat)speed {
  Ball *ball = [Ball spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(radius, radius)];
  ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
  float velX = arc4random_uniform(speed/2);
  float velY = speed-velX;
  int quadrantChance = arc4random_uniform(100);
  if (quadrantChance <= 25) {
    ball.physicsBody.velocity = CGVectorMake(velX, velY);
  } else if (quadrantChance <= 50) {
    ball.physicsBody.velocity = CGVectorMake(-velX, velY);
  }  else if (quadrantChance <= 75) {
    ball.physicsBody.velocity = CGVectorMake(-velX, -velY);
  }  else {
    ball.physicsBody.velocity = CGVectorMake(velX, -velY);
  }
  ball.physicsBody.friction = 0;
  ball.physicsBody.restitution = 1;
  ball.physicsBody.linearDamping = 0;
  ball.position = position;
  ball.physicsBody.categoryBitMask = 0x1 << 0;
  ball.physicsBody.collisionBitMask = 0x1 << 10;
  ball.physicsBody.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
  return ball;
}

+ (id)newBallWithRadius:(CGFloat)radius position:(CGPoint)position vector:(CGVector)vector {
  Ball *ball = [Ball spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(radius, radius)];
  ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
  ball.physicsBody.velocity = vector;
  ball.physicsBody.friction = 0;
  ball.physicsBody.restitution = 1;
  ball.physicsBody.linearDamping = 0;
  ball.position = position;
  ball.physicsBody.categoryBitMask = 0x1 << 0;
  ball.physicsBody.collisionBitMask = 0x1 << 10;
  ball.physicsBody.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
  return ball;
}

@end
