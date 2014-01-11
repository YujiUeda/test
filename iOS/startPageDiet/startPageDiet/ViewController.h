//
//  ViewController.h
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/02.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
}

@property (nonatomic, retain) UILabel *weight;
@property (nonatomic, retain) UILabel *comment;
@property (nonatomic, retain) UILabel *dw;
@property (nonatomic, retain) UILabel *gd;

- (void)initButton;
- (void)initWeightView;
- (void)initFukidashi;
- (void)didTappedButton:(UIButton*)button;
- (void)didTappedSendButton;

@end
