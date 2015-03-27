//
//  GameViewController.h
//  CONTAIN
//

//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@interface GameViewController : UIViewController <GKGameCenterControllerDelegate>

+ (instancetype)sharedViewActions;
-(void)showGameCenterViewController:(NSNotification *)notification;

@property (nonatomic, readonly) GKGameCenterViewController *gcViewController;

@end
