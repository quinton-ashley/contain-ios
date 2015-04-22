//
//  Ball.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import "Ball.h"

@implementation Ball
+ (id)newBallWithRadiusOf:(CGFloat)radius atPoint:(CGPoint)position withSpeed:(CGFloat)speed {
    Ball *oneball = [Ball shapeNodeWithCircleOfRadius:radius];
    oneball.fillColor = [UIColor clearColor];
    oneball.strokeColor = [UIColor whiteColor];
    oneball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    float velX = arc4random_uniform(speed/2);
    float velY = speed-velX;
    int quadrantChance = arc4random_uniform(100);
    if (quadrantChance <= 25) {
        oneball.physicsBody.velocity = CGVectorMake(velX, velY);
    } else if (quadrantChance <= 50) {
        oneball.physicsBody.velocity = CGVectorMake(-velX, velY);
    }  else if (quadrantChance <= 75) {
        oneball.physicsBody.velocity = CGVectorMake(-velX, -velY);
    }  else {
        oneball.physicsBody.velocity = CGVectorMake(velX, -velY);
    }
    oneball.physicsBody.friction = 0;
    oneball.physicsBody.restitution = 1;
    oneball.physicsBody.linearDamping = 0;
    oneball.position = position;
    oneball.physicsBody.categoryBitMask = 0x1 << 0;
    oneball.physicsBody.collisionBitMask = 0x1 << 10;
    oneball.physicsBody.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
    return oneball;
}

+ (id)newBallWithRadiusOf:(CGFloat)radius atPoint:(CGPoint)position withVector:(CGVector)vector {
    Ball *oneball = [Ball shapeNodeWithCircleOfRadius:radius];
    oneball.fillColor = [UIColor clearColor];
    oneball.strokeColor = [UIColor whiteColor];
    oneball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    oneball.physicsBody.velocity = vector;
    oneball.physicsBody.friction = 0;
    oneball.physicsBody.restitution = 1;
    oneball.physicsBody.linearDamping = 0;
    oneball.position = position;
    oneball.physicsBody.categoryBitMask = 0x1 << 0;
    oneball.physicsBody.collisionBitMask = 0x1 << 10;
    oneball.physicsBody.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
    return oneball;
}
@end