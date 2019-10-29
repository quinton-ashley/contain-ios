//
//  Ball.h
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Ball : SKSpriteNode

+ (id)newBallWithRadius:(CGFloat)radius position:(CGPoint)position speed:(CGFloat)speed;
+ (id)newBallWithRadius:(CGFloat)radius position:(CGPoint)position vector:(CGVector)vector;

@end
