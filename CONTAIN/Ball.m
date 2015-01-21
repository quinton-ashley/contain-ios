//
//  Ball.m
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import "Ball.h"

@implementation Ball
+ (id)newBallWithRadiusOf:(CGFloat)radius atPoint:(CGPoint)position {
    Ball *oneball = [Ball shapeNodeWithCircleOfRadius:radius];
    oneball.fillColor = [UIColor whiteColor];
    oneball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    oneball.physicsBody.velocity = CGVectorMake(0.0f, 40.0f);
    oneball.physicsBody.friction = 0;
    oneball.physicsBody.restitution = 1;
    oneball.physicsBody.linearDamping = 0;
    oneball.position = position;
    oneball.physicsBody.categoryBitMask = 0x1 << 0;
    oneball.physicsBody.collisionBitMask = 0x1 << 3;
    oneball.physicsBody.contactTestBitMask = 0x1 << 1 | 0x1 << 2;
    return oneball;
}
//-(NSString *)description{
//    
//    return @"FirstName: %f, LastName: %f",
//    self.position.x, self.position.y;
//}
@end