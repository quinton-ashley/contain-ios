//
//  GameViewController.h
//  CONTAIN
//

//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//


#import <GameKit/GameKit.h>

#if TARGET_OS_IPHONE
@interface GameViewController : UIViewController <GKGameCenterControllerDelegate>
#else
@interface GameViewController : NSViewController <GKGameCenterControllerDelegate>
#endif
@property (nonatomic, readonly) GameScene *scene0;

@end
