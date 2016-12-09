//
//  RCSRDZViewController.m
//  HHause
//
//  Created by HHause on 16/6/22.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSRDZViewController.h"
#import "RCSQSRDZViewController.h"
@interface RCSRDZViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)srdzBtn:(id)sender;
- (IBAction)cancleBtn:(id)sender;

@end

@implementation RCSRDZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.delegate =self;
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(kScreeWidth, 1031*kScreeHeight/667);
    // 是否反弹
        _scrollView.bounces = YES;
//     是否滚动
        _scrollView.scrollEnabled = YES;
//     设置indicator风格
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;

//    // 提示用户,Indicators flash
//    [_scrollView flashScrollIndicators];
//    // 是否同时运动,lock
//    _scrollView.directionalLockEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.alpha=0;
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    self.tabBarController.tabBar.alpha=1;
}
- (IBAction)srdzBtn:(id)sender {
    RCSQSRDZViewController * sqsrdz =[[RCSQSRDZViewController alloc]init];
    [self presentViewController:sqsrdz animated:YES completion:^{
       
    }];
}

- (IBAction)cancleBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)dealloc
{
    
//    NSLog(@"\n\t\n\t\n\t 私人定制 释放了\n\t\n\t\n\t");
}
@end
