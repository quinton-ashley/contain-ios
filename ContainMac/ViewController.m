//
//  ViewController.m
//  ContainMac
//
//  Created by Quinton Ashley on 9/28/16.
//  Copyright © 2016 Quinton Ashley. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

@end
