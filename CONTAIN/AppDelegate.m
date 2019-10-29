//
//  AppDelegate.m
//  CONTAIN
//
//  Created by Quinton Ashley on 12/18/14.
//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "AppDelegate.h"

#if TARGET_OS_IPHONE

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#else

#import "GameScene.h"

@implementation AppDelegate {
  GameScene *scene0;
}

@synthesize window = _window;

-(id)init {
  if (self = [super init]) {
    NSUInteger windowStyleMask = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable | NSWindowStyleMaskClosable | NSWindowCollectionBehaviorFullScreenDisallowsTiling;
    _window = [[NSWindow alloc] initWithContentRect:NSMakeRect(360.0, 640.0, 720.0, 1000.0) styleMask:windowStyleMask backing:NSBackingStoreBuffered defer:YES];
    _window.aspectRatio = NSMakeSize(9.0, 16.0);
    _window.collectionBehavior = NSWindowCollectionBehaviorFullScreenDisallowsTiling;
    _window.backgroundColor = [NSColor whiteColor];
    _window.title = @"Contain";
//    [_window toggleFullScreen:nil];
    
    // Setup Preference Menu Action/Target on MainMenu
    //        NSMenu *mm = [NSApp mainMenu];
    //        NSMenuItem *myBareMetalAppItem = [mm itemAtIndex:0];
    //        NSMenu *subMenu = [myBareMetalAppItem submenu];
    //        NSMenuItem *prefMenu = [subMenu itemWithTag:100];
    //        prefMenu.target = self;
    //        prefMenu.action = @selector(showPreferencesMenu:);
  }
  return self;
}

-(void)applicationWillFinishLaunching:(NSNotification *)notification {
  self.skView = [[SKView alloc] initWithFrame:_window.frame];
  //NSLog(@"window frame x %f", _window.frame.size.width);
  scene0 = [[GameScene alloc] initWithSize:_window.frame.size];
  [_window makeKeyAndOrderFront:self];
  [self.skView presentScene:scene0];
  [_window setContentView:_skView];
}

-(void)applicationDidFinishLaunching:(NSNotification *)notification {
  
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
  return YES;
}

#endif

@end
