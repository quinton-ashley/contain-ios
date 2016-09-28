//
//  GameKitHelper.m
//  CONTAIN
//
//  Created by Quinton Ashley on 3/25/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import "GameKitHelper.h"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";
NSString *const PresentGameCenterViewController = @"present_game_center_view_controller";
NSString *const LocalPlayerIsAuthenticated = @"local_player_authenticated";

@implementation GameKitHelper {
  BOOL _enableGameCenter;
}

+ (instancetype)sharedGameKitHelper {
  static GameKitHelper *sharedGameKitHelper;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedGameKitHelper = [[GameKitHelper alloc] init];
  });
  return sharedGameKitHelper;
}

- (id)init {
  self = [super init];
  if (self) {
    _enableGameCenter = YES;
  }
  return self;
}

- (void)authenticateLocalPlayer {
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  if (localPlayer.isAuthenticated) {
    [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsAuthenticated object:nil];
    return;
  }
  localPlayer.authenticateHandler  =
  ^(UIViewController *viewController, NSError *error) {
    [self setLastError:error];
    if(viewController != nil) {
      [self setAuthenticationViewController:viewController];
    } else if([GKLocalPlayer localPlayer].isAuthenticated) {
      _enableGameCenter = YES;
      [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsAuthenticated object:nil];
    } else {
      _enableGameCenter = NO;
    }
  };
}

- (void)setAuthenticationViewController:(UIViewController *)authenticationViewController {
  if (authenticationViewController != nil) {
    _authenticationViewController = authenticationViewController;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:PresentAuthenticationViewController
     object:self];
  }
}

- (void)setLastError:(NSError *)error {
  _lastError = [error copy];
  if (_lastError) {
    NSLog(@"GameKitHelper ERROR: %@",
          [[_lastError userInfo] description]);
  }
}

@end
