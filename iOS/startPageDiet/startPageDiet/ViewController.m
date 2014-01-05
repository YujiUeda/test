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
    
//    // タブviewのレイアウト仮置き
//    UILabel *tab = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 36, 36)];
//    tab.backgroundColor = [UIColor redColor];
//    [self.view addSubview:tab];
}

- (void)initFukidashi
{
    // 猫
    UIImageView *neko = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"neko.png"]];
    neko.frame = CGRectMake(20, 70, 70, 50);
    [self.view addSubview:neko];

    
    
    
    // 吹き出し
    UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fukidashi.png"]];
    imv.frame = CGRectMake(80, 20, 220, 80);
    [self.view addSubview:imv];

    // コメント
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 150, 60)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    [imv addSubview:label];
    
    NSURL *url = [NSURL URLWithString:kInputMenberUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    
    // エラー処理
    NSString *errorString = [error localizedDescription];
    if (0 < [errorString length] || response.statusCode >= 400 ){
        label.text = @"通信エラーだニャ";
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if([dic[@"all"] isEqualToNumber:@0]){
        label.text = @"まだ誰も登録されてないニャ";
    } else if([dic[@"input"] isEqualToNumber:@0]){
        label.text = @"本日はまだ誰も入力してないニャ";
    } else {
        label.text = [NSString stringWithFormat:@"本日は%@人中%@人が入力済みだニャ", dic[@"all"],dic[@"input"]];
    }
    
}

- (void)initWeightView
{
    // base
    UIView *base = [[UIView alloc] initWithFrame:CGRectMake(20, 120, 280, 80)];
    [base.layer setCornerRadius:5.0f];
    [base.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [base.layer setBorderWidth:1.0f];
    base.layer.shadowOpacity = 0.5f;
    base.layer.shadowOffset = CGSizeMake(2, 2);
    base.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:base];
    
    // 体重
    self.weight = [[UILabel alloc] initWithFrame:CGRectMake(125, 25, 110, 34)];
    self.weight.backgroundColor = [UIColor clearColor];
    self.weight.font = [UIFont fontWithName:@"AppleGothic" size:32];
    self.weight.text = @"0.0";
    self.weight.textAlignment = NSTextAlignmentRight;
    [base addSubview:self.weight];
    
    // キログラム
    UILabel *kg = [[UILabel alloc] initWithFrame:CGRectMake(240, 15, 50, 70)];
    kg.text = @"kg";
    kg.font = [UIFont fontWithName:@"AppleGothic" size:22];
    [base addSubview:kg];
    
    // ライン
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(125, 10, 2, 60)];
    line.backgroundColor = [UIColor blackColor];
    [base addSubview:line];
    
    // 今日の体重
    UILabel *today = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 110, 24)];
    today.text = @"今日の体重";
    today.font = [UIFont fontWithName:@"AppleGothic" size:22];
    today.backgroundColor = [UIColor clearColor];
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
        btn.frame = CGRectMake(20+100*x, 60*y+220, 80, 50);
        [btn.layer setCornerRadius:5.0f];
        [btn.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [btn.layer setBorderWidth:1.0f];
        btn.layer.shadowOpacity = 0.5f;
        btn.layer.shadowOffset = CGSizeMake(2, 2);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(didTappedButton:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }
    
    // 送信ボタン
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"送信" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 460, 280, 50);
    [btn.layer setCornerRadius:5.0f];
    [btn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btn.layer setBorderWidth:1.0f];
    btn.layer.shadowOpacity = 0.5f;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.shadowOffset = CGSizeMake(2, 2);
    [btn addTarget:self action:@selector(didTappedSendButton) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:btn];
    
    
    
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
    
    if( [self.weight.text isEqualToString:@"0.0"] ){
        self.weight.text = @"";
        self.weight.text = [NSString stringWithFormat:@"%@%@", self.weight.text, title];
    } else {
        self.weight.text = [NSString stringWithFormat:@"%@%@", self.weight.text, title];
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
                                                                                 (CFStringRef)[ud objectForKey:@"kMailAddress"], // ←エンコード前の文字列(NSStringクラス)
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
    NSLog(@"%@",mailAddress);
    
    NSString *reqUrl =[NSString stringWithFormat:@"http://wu-tang.sakura.ne.jp/api/startPage/inputWeight.php?diffWeight=%f&goalDegree=%f&mailAddress=%@", diffWeight, goalDegree, mailAddress];
    
    NSLog(@"%@",reqUrl);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
