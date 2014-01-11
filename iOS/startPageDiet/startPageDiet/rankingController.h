//
//  rankingController.h
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/05.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rankingController : UIViewController<UITableViewDelegate>
{
    
}

@property (nonatomic, retain) NSArray *arr;
@property (nonatomic, retain) UITableView *tv;

- (void)initTable;

@end
