//
//  main.m
//  CONTAIN
//
//  Created by Quinton Ashley on 12/18/14.
//  Copyright (c) 2014 Quinton Ashley. All rights reserved.
//

#import "AppDelegate.h"
#import "CONTAIN-Swift.h"

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

int main(int argc, char * argv[]) {
  @autoreleasepool {
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}

#else

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
  NSArray *tl;
  NSApplication *application = [NSApplication sharedApplication];
  [[NSBundle mainBundle] loadNibNamed:@"MainMenu" owner:application topLevelObjects:&tl];
  
  AppDelegate *applicationDelegate = [[AppDelegate alloc] init];      // Instantiate App  delegate
  [application setDelegate:applicationDelegate];                      // Assign delegate to the NSApplication
  [application run];                                                  // Call the Apps Run method
  
  return 0;
}

#endif
