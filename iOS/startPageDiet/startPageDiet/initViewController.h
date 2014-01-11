//
//  initViewController.h
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/10.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface initViewController : UIViewController
{
    
}

@property (nonatomic, retain) UITextField *account;
@property (nonatomic, retain) UITextField *startWeight;
@property (nonatomic, retain) UITextField *goalWeight;

- (void)saveData;


@end
