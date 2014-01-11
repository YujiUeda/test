//
//  main.m
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/02.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

//int main(int argc, char * argv[])
//{
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}

int main(int argc, char *argv[])
{

    int retVal;
    @try {
        retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    @catch (NSException *exception) {
        //NSLog(@"%@", [exception callStackSymbols]); //< ★1
        @throw exception; //< ★2
    }
    @finally {

    }
    return retVal;
}
