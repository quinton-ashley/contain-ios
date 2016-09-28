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
  Paddle *onePad = [Paddle shapeNodeWithPath:path];
  onePad.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
  onePad.strokeColor = [SKColor clearColor];
  onePad.physicsBody.categoryBitMask = 0x1 << 1;
  onePad.physicsBody.collisionBitMask = 0x1 << 10;
  onePad.physicsBody.contactTestBitMask = 0x1 << 0;
  return onePad;
}
@end
