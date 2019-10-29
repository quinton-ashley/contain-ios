//
//  GameScene.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "TargetConditionals.h"
#import <SpriteKit/SpriteKit.h>
#import "Ball.h"
#import "Paddle.h"

#if TARGET_OS_IPHONE
#import <GameKit/GameKit.h>
#import "GameViewController.h"
#import "GameKitHelper.h"
#endif

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
  
}

@end
