//
//  RCAboutAndErWeiMaViewController.m
//  HHause
//
//  Created by HHause on 16/6/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCAboutAndErWeiMaViewController.h"

@interface RCAboutAndErWeiMaViewController ()

- (IBAction)backBtn:(id)sender;

@end

@implementation RCAboutAndErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"形状-19-拷贝-3.png"] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
//    self.navigationItem.rightBarButtonItem = share;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark--------------------------------Appear--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)share{
    //1、创建分享参数
    NSArray* imageArray = imageArray = @[[UIImage imageNamed:@"icon"],[UIImage imageNamed:@"icon"],[UIImage imageNamed:@"icon"],[UIImage imageNamed:@"icon"]];
    
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    //    //分享链接
    NSURL * _shareUrl =[NSURL URLWithString:@"https://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"];
    [RCShare shareText:@"海际悦家 - 值得信赖的海外置业专家" imageArray:imageArray url:_shareUrl title:@"邀请注册"];
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
