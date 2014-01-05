//
//  AppDelegate.m
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/02.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "listController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // 初期値設定
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setFloat:110.0 forKey:@"kStartWeight"];
    [ud setFloat:100.0 forKey:@"kFinishWeight"];
    [ud setObject:@"yueda@yahoo-corp.jp" forKey:@"kMailAddress"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // タブの中身（UIViewController）をインスタンス化
    tab1 = [[ViewController alloc]init]; // タブ1
    tab2 = [[listController alloc]init]; // タブ2
    NSArray *tabs = [NSArray arrayWithObjects:tab1, tab2, nil];
    
    // タブコントローラをインスタンス化
    tabController = [[UITabBarController alloc]init];
    
    // タブコントローラにタブの中身をセット
    [tabController setViewControllers:tabs animated:NO];
    
    // タブコントローラのビューをウィンドウに貼付ける
    [self.window addSubview:tabController.view];
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
