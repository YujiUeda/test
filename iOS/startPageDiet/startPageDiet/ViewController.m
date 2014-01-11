//
//  ViewController.m
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/02.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kInputMenberUrl  @"http://wu-tang.sakura.ne.jp/api/startPage/getInputMember.json"

@interface ViewController ()

@end

@implementation ViewController

@synthesize weight = _weight;
@synthesize comment = _comment;
@synthesize dw = _dw;
@synthesize gd = _gd;
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
                           initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{

    // 吹き出しの更新
    NSURL *url = [NSURL URLWithString:kInputMenberUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    // エラー処理
    NSString *errorString = [error localizedDescription];
    if (0 < [errorString length] || response.statusCode >= 400 ){
        self.comment.text = @"通信エラーだニャ";
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if([dic[@"all"] isEqualToNumber:@0]){
        self.comment.text = @"まだ誰も登録されてないニャ";
    } else if([dic[@"input"] isEqualToNumber:@0]){
        self.comment.text = @"本日はまだ誰も入力してないニャ";
    } else {
        self.comment.text = [NSString stringWithFormat:@"本日は%@人中%@人が入力済みだニャ", dic[@"all"],dic[@"input"]];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // 吹き出しを配置
    [self initFukidashi];
    
    // メモリを配置
    [self initWeightView];

    // btnを配置
    [self initButton];

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
    self.comment = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 135, 36)];
    self.comment.font = [UIFont fontWithName:@"AppleGothic" size:14];
    self.comment.backgroundColor = [UIColor clearColor];
    self.comment.numberOfLines = 2;
    [imv addSubview:self.comment];
    
}

- (void)initWeightView
{
    // base
    UIView *base = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 320, 65)];
    [base.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [base.layer setBorderWidth:0.5f];
    base.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1];
    [self.view addSubview:base];
    
    // 体重
    self.weight = [[UILabel alloc] initWithFrame:CGRectMake(125, 18, 110, 34)];
    self.weight.backgroundColor = [UIColor clearColor];
    self.weight.font = [UIFont fontWithName:@"AppleGothic" size:32];
    self.weight.text = @"0.0";
    self.weight.textAlignment = NSTextAlignmentRight;
    self.weight.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [base addSubview:self.weight];
    
    // キログラム
    UILabel *kg = [[UILabel alloc] initWithFrame:CGRectMake(285, 0, 50, 70)];
    kg.text = @"kg";
    kg.font = [UIFont fontWithName:@"AppleGothic" size:18];
    kg.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [base addSubview:kg];
    
    // 今日の体重
    UILabel *today = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 110, 24)];
    today.text = @"今日の体重";
    today.font = [UIFont fontWithName:@"AppleGothic" size:18];
    today.backgroundColor = [UIColor clearColor];
    today.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [base addSubview:today];
    
    
    
}

- (void)initButton
{
    // 数字ボタン
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor = [UIColor whiteColor];
        
        NSString *title;
        switch (i) {
            case 9:
                title = @"クリア";
                break;
            case 10:
                title = @"0";
                break;
            case 11:
                title = @".";
                break;
            default:
                title = [NSString stringWithFormat:@"%d",i+1];
                break;
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
        int x = i%3;
        int y = i/3;
        btn.frame = CGRectMake(107*x, 64*y+150, 107, 64);
        [btn.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [btn.layer setBorderWidth:0.5f];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
        [btn addTarget:self action:@selector(didTappedButton:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [self.view addSubview:btn];
    }
    
    
    // 送信データ表示
    UILabel *postData = [[UILabel alloc] initWithFrame:CGRectMake(0, 406, 320, 52)];
    postData.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1];
    [self.view addSubview:postData];
    
    // 減少体重
    self.dw = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    self.dw.backgroundColor = [UIColor clearColor];
    self.dw.text = @"-kg減";
    self.dw.textColor = [UIColor colorWithRed:255.0/255.0 green:125.0/255 blue:0.0/0.0 alpha:1];
    self.dw.font = [UIFont systemFontOfSize:22];
    self.dw.backgroundColor = [UIColor clearColor];
    self.dw.textAlignment = NSTextAlignmentRight;
    [postData addSubview:self.dw];
    
    // 達成率
    self.gd = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 90, 50)];
    self.gd.backgroundColor = [UIColor clearColor];
    self.gd.text = @"-100.0%";
    self.gd.textColor = [UIColor colorWithRed:255.0/255.0 green:125.0/255 blue:0.0/0.0 alpha:1];
    self.gd.font = [UIFont systemFontOfSize:22];
    self.gd.backgroundColor = [UIColor clearColor];
    [postData addSubview:self.gd];
    
    // 達成
    UILabel *goal = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 70, 50)];
    goal.backgroundColor = [UIColor clearColor];
    goal.text = @"達成！";
    goal.textColor = [UIColor whiteColor];
    goal.font = [UIFont systemFontOfSize:22];
    goal.backgroundColor = [UIColor clearColor];
    [postData addSubview:goal];
    
    
    
    
    // 送信ボタン
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"送信" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 458, 320, 60);
    [btn.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [btn.layer setBorderWidth:0.5f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didTappedSendButton) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:btn];
    
    //
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    msg.text = @"体重差、目標達成率を";
    
    
    
    
    
    
}

- (void)didTappedButton:(UIButton *)button
{
    NSLog(@"%d", button.tag);
    NSString *title;
    switch (button.tag) {
        case 9:
            title = @"0.0";
            self.weight.text = title;
            return;
            break;
        case 10:
            title = @"0";
            break;
        case 11:
            title = @".";
            break;
        default:
            title = [NSString stringWithFormat:@"%d",button.tag+1];
            break;
    }
    
    // 5桁以上なら何もしない
    if( self.weight.text.length > 4){
        return;
    }
    
    // 一番左の桁が0なら何もしない
    if([[self.weight.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"] && button.tag == 10){
        return;
    }
    
    // 一番左の桁が.なら何もしない
    NSRange range = [self.weight.text rangeOfString:@"."];
    
    if( ( range.location != NSNotFound || [self.weight.text isEqualToString:@"0.0"] )&& button.tag == 11){
        return;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if( [self.weight.text isEqualToString:@"0.0"] ){
        self.weight.text = @"";
        self.weight.text = [NSString stringWithFormat:@"%@%@", self.weight.text, title];
    } else {
        self.weight.text = [NSString stringWithFormat:@"%@%@", self.weight.text, title];
        self.dw.text = [NSString stringWithFormat:@"%.1fkg減",[ud floatForKey:@"kStartWeight"] - [self.weight.text floatValue]];
        self.gd.text = [NSString stringWithFormat:@"%.1f％", 100*(-[ud floatForKey:@"kStartWeight"] + [self.weight.text floatValue])/([ud floatForKey:@"kFinishWeight"] - [ud floatForKey:@"kStartWeight"])];

    }
    
}

- (void)didTappedSendButton
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    // 体重差
    float diffWeight = [ud floatForKey:@"kStartWeight"] - [self.weight.text floatValue];
    NSLog(@"%f", diffWeight);

    // 目標達成度
    float goalDegree = diffWeight / ([ud floatForKey:@"kStartWeight"] - [ud floatForKey:@"kFinishWeight"]) * 100;
    
    NSLog(@"%f％", goalDegree);
    
    // メアド
    NSString *mailAddress = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 kCFAllocatorDefault,
                                                                                 (CFStringRef)[NSString stringWithFormat:@"%@%@",[ud objectForKey:@"kAccount"], @"@yahoo-corp.jp"], // ←エンコード前の文字列(NSStringクラス)
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
    NSLog(@"%@",mailAddress);
    
    NSString *reqUrl =[NSString stringWithFormat:@"http://wu-tang.sakura.ne.jp/api/startPage/inputWeight.php?diffWeight=%f&goalDegree=%f&mailAddress=%@", diffWeight, goalDegree, mailAddress];
    
    NSLog(@"%@",reqUrl);
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"お知らせ" message:[NSString stringWithFormat:@"体重差%.1fkg,達成度%.1f％を送信しました",diffWeight,goalDegree]
                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
