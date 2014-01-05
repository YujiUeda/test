//
//  AppDelegate.h
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/02.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class listController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ViewController *tab1;
    listController *tab2;
    UITabBarController *tabController;
}
@property (strong, nonatomic) UIWindow *window;

@end
