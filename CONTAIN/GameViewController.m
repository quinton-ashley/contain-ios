//
//  GameViewController.m
//  CONTAIN
//
//  Created by Quinton Ashley on 12/18/14.
//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "GameKitHelper.h"

@interface GameViewController() <GKGameCenterControllerDelegate, ADBannerViewDelegate> {
    ADBannerView *_adBanner;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView *skView = (SKView *)self.view;
    GameScene *scene = [[GameScene alloc] initWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [skView presentScene:scene];
}

- (void)showAuthenticationViewController {
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    [self presentViewController:gameKitHelper.authenticationViewController animated:YES completion:nil];
}

- (void)showGameCenterViewController:(NSNotification *)notification {
    _gcViewController = [[GKGameCenterViewController alloc] init];
    _gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
    _gcViewController.gameCenterDelegate = self;
    [self presentViewController:_gcViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)viewDidAppear:(BOOL)animated {
    if ([[UIScreen mainScreen] bounds].size.height > 550) {
        [super viewDidAppear:animated];
        _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
        _adBanner.delegate = self;
        [self.view addSubview:_adBanner];
    }
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showAuthenticationViewController)
     name:PresentAuthenticationViewController
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showGameCenterViewController:)
     name:PresentGameCenterViewController
     object:nil];
    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    banner.frame = CGRectMake(0, self.view.frame.size.height-50, 320, 50);
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    banner.frame = CGRectMake(0, self.view.frame.size.height+100, 320, 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
