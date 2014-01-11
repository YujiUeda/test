//
//  initViewController.m
//  startPageDiet
//
//  Created by 植田 裕司 on 2014/01/10.
//  Copyright (c) 2014年 植田 裕司. All rights reserved.
//

#import "initViewController.h"
#import "ViewController.h"
#import "listController.h"
#import "rankingController.h"

@implementation initViewController

@synthesize account = _account;
@synthesize startWeight = _startWeight;
@synthesize goalWeight = _goalWeight;

/**
 * イニシャライザ
 */
- (id)init
{
    self = [super init];
    if (self) {
        // 背景色を設定
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{

    [self initFukidashi];
    
    UIView *base = [[UIView alloc] initWithFrame:CGRectMake(0, 84, 320, 500)];
    base.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:base];
    
    //
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 100, 30)];
    label1.text = @"アカウント";
    [base addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 77, 100, 30)];
    label2.text = @"開始体重";
    [base addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(3, 151, 100, 30)];
    label3.text = @"目標体重";
    [base addSubview:label3];
    // ドメイン
    UILabel *domain = [[UILabel alloc] initWithFrame:CGRectMake(162, 33, 140, 40)];
    domain.text = @"@yahoo-corp.jp";
    [base addSubview:domain];
    
    // アカウント
    self.account = [[UITextField alloc] initWithFrame:CGRectMake(20, 33, 140, 40)];
    self.account.font = [UIFont systemFontOfSize:20.0f];
    self.account.textAlignment = NSTextAlignmentRight;
    self.account.backgroundColor = [UIColor whiteColor];
    self.account.keyboardType = UIKeyboardTypeASCIICapable;
    [base addSubview:self.account];

    // キログラム
    UILabel *kg1 = [[UILabel alloc] initWithFrame:CGRectMake(162, 110, 140, 40)];
    kg1.text = @"kg";
    [base addSubview:kg1];
    
    // 開始体重
    self.startWeight = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, 140, 40)];
    self.startWeight.font = [UIFont systemFontOfSize:20.0f];
    self.startWeight.textAlignment = NSTextAlignmentRight;
    self.startWeight.keyboardType = UIKeyboardTypeDecimalPad;
    self.startWeight.backgroundColor = [UIColor whiteColor];
    [base addSubview:self.startWeight];

    // キログラム
    UILabel *kg2 = [[UILabel alloc] initWithFrame:CGRectMake(162, 184, 140, 40)];
    kg2.text = @"kg";
    [base addSubview:kg2];
    
    // 目標体重
    self.goalWeight = [[UITextField alloc] initWithFrame:CGRectMake(20, 184, 140, 40)];
    self.goalWeight.font = [UIFont systemFontOfSize:20.0f];
    self.goalWeight.textAlignment = NSTextAlignmentRight;
    self.goalWeight.keyboardType = UIKeyboardTypeDecimalPad;
    self.goalWeight.backgroundColor = [UIColor whiteColor];
    [base addSubview:self.goalWeight];
    

    
    // ボタン
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(210, 240, 100, 100);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    // ボタンがタッチダウンされた時にhogeメソッドを呼び出す
    [btn addTarget:self action:@selector(saveData)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
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
    UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 135, 40)];
    comment.font = [UIFont fontWithName:@"AppleGothic" size:10];
    comment.backgroundColor = [UIColor clearColor];
    comment.numberOfLines = 3;
    comment.text = @"初期情報を超慎重に入力するニャ。ミスるとやばいニャ。体重は送信しないニャ";
    [imv addSubview:comment];
    
}

- (void)saveData
{

    @try {
        // バリデーションチェック
        float startWeight = self.startWeight.text.floatValue;
        float goalWeight = self.goalWeight.text.floatValue;
        // 体重っぽい値じゃなかったらエラー
        if( !(30 <= startWeight && startWeight <= 150)){
            @throw @"開始体重の値がおかしいですニャ";
        }
        if( !(30 <= goalWeight && goalWeight <= 150)){
            @throw @"目標体重の値がおかしいですニャ";
        }
        
        // UserDefaultに設定する
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setFloat:startWeight forKey:@"kStartWeight"];
        [ud setFloat:goalWeight forKey:@"kFinishWeight"];
        [ud setObject:self.account.text forKey:@"kAccount"];
        
        // 生成と同時に各種設定も完了させる例
        UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:@"登録完了"
         message:@"頑張るニャ！"
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil
         ];
        
        [alert show];
        
    }
    @catch (NSString *exception) {
        // 生成と同時に各種設定も完了させる例
        UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:@"登録エラー"
         message:exception
         delegate:nil
         cancelButtonTitle:nil
         otherButtonTitles:@"再入力", nil
         ];
        
        [alert show];
    }

    
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.view endEditing:YES];
    

    
    ViewController *tab1 = [[ViewController alloc]init]; // タブ1
    tab1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"記入" image:[UIImage imageNamed:@"tab_post.png"] selectedImage:[UIImage imageNamed:@"tab_post.png"]];
    listController *tab2 = [[listController alloc]init]; // タブ2
    tab2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"戦歴" image:[UIImage imageNamed:@"tab_list.png"] selectedImage:[UIImage imageNamed:@"tab_list.png"]];
    rankingController *tab3 = [[rankingController alloc]init]; // タブ3
    tab3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ランキング" image:[UIImage imageNamed:@"tab_rank.png"] selectedImage:[UIImage imageNamed:@"tab_rank.png"]];
    NSArray *tabs = [NSArray arrayWithObjects:tab1, tab2, tab3, nil];
    UITabBarController *tabController = [[UITabBarController alloc] init];
    [tabController setViewControllers:tabs animated:NO];
    
    //画面遷移アニメーションの指定
    tabController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    //画面遷移実行
    [self presentViewController:tabController animated:YES completion:nil];
    
    
    
    
    
}






@end
