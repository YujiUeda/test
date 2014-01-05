//
//  listController.m
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/05.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import "listController.h"

@implementation listController

/**
 * イニシャライザ
 */
- (id)init
{
    self = [super init];
    if (self) {
        // 背景色を設定
        self.view.backgroundColor = [UIColor redColor];
        
        // タブバーのアイコンを設定
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTabBarSystemItem:UITabBarSystemItemRecents tag:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    // table初期化
    [self initTable];
    
}

- (void)initTable
{
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 320, 400) style:UITableViewStylePlain];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
    
}

/**
 * テーブルのセルの数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // セルの内容はNSArray型の「items」にセットされているものとする
    return 3;
}

/**
 * 指定されたインデックスパスのセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルにテキストを設定
    // セルの内容はNSArray型の「items」にセットされているものとする
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
    date.text = @"1/15(月)";
    [cell addSubview:date];
    
    
    return cell;
}

@end
