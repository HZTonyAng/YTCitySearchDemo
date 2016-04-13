//
//  ViewController.m
//  YTCitySearchDemo
//
//  Created by TonyAng on 16/4/13.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "JJSearchProvinceTableController.h"

@interface ViewController ()
/// 点击搜索城市的按钮
@property (nonatomic, strong) UIButton *ytCitySearchBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"YTSearchCity";
    self.ytCitySearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ytCitySearchBtn.frame = CGRectMake(0, 0, 120, 120);
    [self.ytCitySearchBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ytCitySearchBtn setTitle:@"选择城市" forState: UIControlStateNormal];
    self.ytCitySearchBtn.center = self.view.center;
    [self.ytCitySearchBtn setTitleColor:[UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:self.ytCitySearchBtn];
    /**
     *  注册通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backCityName:) name:@"cityName" object:nil];
    
}

/**
 *  监听到通知执行的方法
 */
- (void)backCityName:(NSNotification *)noti {
    NSLog(@"---%@",noti.userInfo[@"cityName"]);
    [self.ytCitySearchBtn setTitle:noti.userInfo[@"cityName"] forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  监听到通知执行的方法
 */
- (void)OnClick:(UIButton *)sender {
    [self.navigationController pushViewController:[JJSearchProvinceTableController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
