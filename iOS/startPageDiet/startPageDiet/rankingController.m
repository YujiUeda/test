//
//  rankingController.m
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/05.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import "rankingController.h"

@implementation rankingController

@synthesize arr = _arr;
@synthesize tv = _tv;
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
        
        self.arr = [NSArray array];
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
    
    // 通信
    [self getRankingData];
    
    
}

- (void)getRankingData
{
    // 吹き出しの更新
    NSURL *url = [NSURL URLWithString:@"http://wu-tang.sakura.ne.jp/api/startPage/getRanking.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    // エラー処理
    NSString *errorString = [error localizedDescription];
    if (0 < [errorString length] || response.statusCode >= 400 ){
        NSLog(@"エラー");
        return;
    }
    self.arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"%@", self.arr[0][@"data"][0][@"name"]);
    
    [self.tv reloadData];
    
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
    
    // コメント
    UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 135, 36)];
    comment.font = [UIFont fontWithName:@"AppleGothic" size:14];
    comment.backgroundColor = [UIColor clearColor];
    comment.numberOfLines = 2;
    comment.text = @"みんながんばるのだニャ";
    [imv addSubview:comment];
    
}

- (void)initTable
{
    self.tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, 320, 434) style:UITableViewStylePlain];
    [self.tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    self.tv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tv];
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

/**
 * テーブルのセルの数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.arr[section][@"data"] count];
}

//セクションの数の設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if( [self.arr count] == 0){
        return 0;
    }
    
    return [self.arr count];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *v = [[UIView alloc] init];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont fontWithName:@"AppleGothic" size:18];
    //lbl.text = @"昨日の減少体重ランキング";
    lbl.textAlignment = NSTextAlignmentCenter;
    [v addSubview:lbl];

    switch (section) {
        case 0:
            lbl.text = @"昨日の減少体重ランキング";
            if([self.arr count] > 0){
                lbl.text = self.arr[section][@"title"];
                
            }
            v.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:118.0/255.0 blue:190.0/255.0 alpha:1];
            break;
        case 1:
            lbl.text = @"昨日の目標達成度ランキング";
            v.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:134.0/255.0 blue:9.0/255.0 alpha:1];
            break;
        case 2:
            lbl.text = @"総合減少体重ランキング";
            v.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:205.0/255.0 blue:50.0/255.0 alpha:1];
            break;
        case 3:
            lbl.text = @"総合目標達成度ランキング";
            v.backgroundColor = [UIColor colorWithRed:186.0/255.0 green:85.0/255.0 blue:211.0/255.0 alpha:1];
            break;
    }
    
    
    return v;
}

/**
 * 指定されたインデックスパスのセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *identifier = @"Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1.0];
    // サブビューを取り除く
    for (UIView *subview in [cell.contentView subviews]) {
        [subview removeFromSuperview];
    }
    
    // 日付
    UILabel *rank = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 30)];
    rank.text = [NSString stringWithFormat:@"%d", (indexPath.row + 1)];
    rank.textColor = [UIColor grayColor];
    switch (indexPath.row) {
        case 0:
            rank.textColor = [UIColor colorWithRed:255.0/255.0 green:214.0/255.0 blue:4.0/255.0 alpha:1];
            break;
        case 1:
            rank.textColor = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1];
            break;
        case 2:
            rank.textColor = [UIColor colorWithRed:216.0/255.0 green:114.0/255.0 blue:47.0/255.0 alpha:1];
            break;
        default:
            break;
    }
    rank.font = [UIFont fontWithName:@"AppleGothic" size:18];
    [cell.contentView addSubview:rank];
    
    // 名前
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(64, 8, 100, 30)];
    name.backgroundColor = [UIColor clearColor];
    name.text = @"yueda";
    name.textColor = [UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1];
    name.font = [UIFont fontWithName:@"AppleGothic" size:22];
    [cell.contentView addSubview:name];
    
    // 体重差
    UILabel *weightDiff = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 90, 30)];
    weightDiff.backgroundColor = [UIColor clearColor];
    weightDiff.text = @"-21.0kg";
    weightDiff.textColor = [UIColor grayColor];
    weightDiff.font = [UIFont fontWithName:@"AppleGothic" size:20];
    [cell.contentView addSubview:weightDiff];
    
    return cell;
}

@end
