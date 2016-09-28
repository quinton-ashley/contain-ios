//
//  GameViewController.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>

@interface GameViewController : UIViewController <GKGameCenterControllerDelegate, ADBannerViewDelegate>

- (void)showGameCenterViewController:(NSNotification *)notification;

@property (nonatomic, readonly) GKGameCenterViewController *gcViewController;

@end

#endif
