//
//  Ball.h
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Ball : SKShapeNode
+ (id)newBallWithRadiusOf:(CGFloat)radius atPoint:(CGPoint)position withSpeed:(CGFloat)speed;
+ (id)newBallWithRadiusOf:(CGFloat)radius atPoint:(CGPoint)position withVector:(CGVector)vector;
@end