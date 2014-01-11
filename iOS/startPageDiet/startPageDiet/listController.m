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
        self.view.backgroundColor = [UIColor whiteColor];
        
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
    
    [self initFukidashi];
    
    // table初期化
    [self initTable];
    
}

- (void)initFukidashi
{
    // 猫
    UIImageView *neko = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"neko.png"]];
    neko.frame = CGRectMake(20, 35, 70, 50);
    [self.view addSubview:neko];
    
    
    // 吹き出し
    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baloon.png"]];
    imv.frame = CGRectMake(100, 25, 200, 60);
    [self.view addSubview:imv];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    
    // コメント
    UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 135, 36)];
    comment.font = [UIFont fontWithName:@"AppleGothic" size:14];
    comment.backgroundColor = [UIColor clearColor];
    comment.numberOfLines = 2;
    comment.text = [NSString stringWithFormat:@"%@のこれまでの記録だニャ", [ud objectForKey:@"kAccount"]];
    [imv addSubview:comment];
    
}

- (void)initTable
{
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, 320, 434) style:UITableViewStylePlain];
    tv.delegate = self;
    tv.dataSource = self;
    tv.backgroundColor = [UIColor clearColor];
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

//セクションの数の設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//セクションのタイトルを設定
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    
    //第１セクションの設定
    if (section==0) {
        return @"あ行";
    }
 
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:0/255.0 alpha:1];

    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 22.0f)];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont fontWithName:@"AppleGothic" size:12];
    lbl.text = @"  day                weight                         体重差     達成率";
    
    [v addSubview:lbl];
    return v;
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
    
    // 日付
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 100, 30)];
    date.text = @"2014/1/15";
    date.textColor = [UIColor grayColor];
    date.font = [UIFont fontWithName:@"AppleGothic" size:12];
    [cell addSubview:date];
    
    // 体重
    UILabel *weight = [[UILabel alloc] initWithFrame:CGRectMake(84, 8, 100, 30)];
    weight.backgroundColor = [UIColor whiteColor];
    weight.text = @"65.0kg";
    weight.textColor = [UIColor grayColor];
    weight.font = [UIFont fontWithName:@"AppleGothic" size:22];
    [cell addSubview:weight];
    
    // 体重差
    UILabel *weightDiff = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 100, 30)];
    weightDiff.backgroundColor = [UIColor whiteColor];
    weightDiff.text = @"-1.0kg";
    weightDiff.textColor = [UIColor grayColor];
    weightDiff.font = [UIFont fontWithName:@"AppleGothic" size:12];
    [cell addSubview:weightDiff];
    
    
    // 達成率
    UILabel *goalDegree = [[UILabel alloc] initWithFrame:CGRectMake(274, 8, 100, 30)];
    goalDegree.backgroundColor = [UIColor whiteColor];
    goalDegree.text = @"-1.0%";
    goalDegree.textColor = [UIColor grayColor];
    goalDegree.font = [UIFont fontWithName:@"AppleGothic" size:12];
    [cell addSubview:goalDegree];
    
    
    
    
    
    return cell;
}

@end
