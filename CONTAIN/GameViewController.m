//
//  GameViewController.m
//  CONTAIN
//
//  Created by Quinton Ashley on 4/28/15.
//  Copyright (c) 2015 Quinton Ashley. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  SKView *skView = (SKView *)self.view;
  _scene0 = [GameScene sceneWithSize:self.view.frame.size];
  [skView presentScene:_scene0];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#if TARGET_OS_IPHONE

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#endif

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)gameCenterViewControllerDidFinish:(nonnull GKGameCenterViewController *)gameCenterViewController {
	
}

- (BOOL)commitEditingAndReturnError:(NSError * _Nullable __autoreleasing * _Nullable)error {
	return true;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
	
}

@end
