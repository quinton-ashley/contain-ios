//
//  GameScene.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "TargetConditionals.h"
#import "Ball.h"
#import "Paddle.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property BOOL pauseGame;

@end
