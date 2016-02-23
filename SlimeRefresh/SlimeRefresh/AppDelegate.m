//
//  AppDelegate.m
//  SlimeRefresh
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import "AppDelegate.h"
#import "SRTViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    self.window.rootViewController = [SRTViewController new];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[SRTViewController new]];
    
    
    return YES;
}

@end
