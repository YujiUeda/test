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
#import "rankingController.h"
#import "initViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if([ud floatForKey:@"kStartWeight"] && [ud floatForKey:@"kFinishWeight"] && [ud objectForKey:@"kAccount"] ){
        // tabViewController
        tab1 = [[ViewController alloc]init]; // タブ1
        tab1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"記入" image:[UIImage imageNamed:@"tab_post.png"] selectedImage:[UIImage imageNamed:@"tab_post.png"]];
        tab2 = [[listController alloc]init]; // タブ2
        tab2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"戦歴" image:[UIImage imageNamed:@"tab_list.png"] selectedImage:[UIImage imageNamed:@"tab_list.png"]];
        tab3 = [[rankingController alloc]init]; // タブ3
        tab3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ランキング" image:[UIImage imageNamed:@"tab_rank.png"] selectedImage:[UIImage imageNamed:@"tab_rank.png"]];
        NSArray *tabs = [NSArray arrayWithObjects:tab1, tab2, tab3, nil];
        tabController = [[UITabBarController alloc] init];
        [tabController setViewControllers:tabs animated:NO];
        [self.window addSubview:tabController.view];
        [self.window makeKeyAndVisible];

} else {
        // 初期値が設定されてなかったら、設定画面へ行く
        initViewController *init = [[initViewController alloc] init];
        [self.window addSubview:init.view];
        [self.window setRootViewController:init];
        [self.window makeKeyAndVisible];
    }
    
        
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
