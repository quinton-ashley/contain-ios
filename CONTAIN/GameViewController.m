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
#import <iAd/iAd.h>

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@interface GameViewController() <GKGameCenterControllerDelegate>

@end

@implementation GameViewController

+ (instancetype)sharedViewActions {
    static GameViewController *sharedViewActions;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedViewActions = [[GameViewController alloc] init];
    });
    return sharedViewActions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    //skView.ignoresSiblingOrder = YES;
    GameScene *scene = [[GameScene alloc] initWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [skView presentScene:scene];
    
}

- (void)showAuthenticationViewController {
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    [self presentViewController:gameKitHelper.authenticationViewController animated:YES completion:nil];
}

-(void)showGameCenterViewController:(NSNotification *)notification {
    _gcViewController = [[GKGameCenterViewController alloc] init];
    _gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
    _gcViewController.gameCenterDelegate = self;
    [self presentViewController:_gcViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    NSLog(@"done");
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[UIScreen mainScreen] bounds].size.height > 550) {
        [super viewDidAppear:animated];
        ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
        [self.view addSubview:adView];
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

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
