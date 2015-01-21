//
//  GameScene.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
    NSMutableArray *paddleArray;
    NSMutableArray *setup;
    NSMutableArray *bounceCheck;
    CGFloat midX;
    CGFloat midY;
    CGFloat ballRadius;
    CGFloat padRadius;
    CGPoint center;
    CGMutablePathRef padPath;
    CGAffineTransform turn;
    uint32_t ballCategory;
    uint32_t paddleCategory;
    uint32_t boundCategory;
    int numPaddles;
    int numBalls;
    double angle;
    double speedFactor;
    int borderSize;
    bool padRevolve;
}
@end
