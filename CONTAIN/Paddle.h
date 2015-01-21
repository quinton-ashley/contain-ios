//
//  Paddle.h
//  CONTAIN
//
//  Created by Quinton Ashley on 1/13/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Paddle : SKShapeNode
+ (id)newPaddleWithPath:(CGPathRef)path withRadius:(CGFloat)radius;
@end
