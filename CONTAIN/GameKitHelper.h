//
//  GameKitHelper.h
//  CONTAIN
//
//  Created by Quinton Ashley on 3/25/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

@import GameKit;
extern NSString *const PresentAuthenticationViewController;
extern NSString *const PresentGameCenterViewController;
extern NSString *const LocalPlayerIsAuthenticated;

@interface GameKitHelper : NSObject

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;

@end