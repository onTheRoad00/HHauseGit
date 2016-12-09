//
//  RCGuide2ViewController.m
//  HHause
//
//  Created by HHause on 16/9/9.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCGuide2ViewController.h"

@interface RCGuide2ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *artticleTitle;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation RCGuide2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.delegate =self;
    float   height;
    _artticleTitle.text = _artTilte;
    if ([_artTilte isEqualToString:@"政策对比"]) {
        height = 2030;
    }else if([_artTilte isEqualToString:@"流程对比"])
    {
        height =1963.5;
    }else if ([_artTilte isEqualToString:@"房价对比"])
    {
        height = 7420;
    }
    // 设置内容大小
    _scrollView.contentSize = CGSizeMake(kScreeWidth, height*kScreeHeight/667);
    
    // 是否反弹
    _scrollView.bounces = YES;
    //     是否滚动
    _scrollView.scrollEnabled = YES;
    //     设置indicator风格
//    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    //    // 提示用户,Indicators flash
//        [_scrollView flashScrollIndicators];
    //    // 是否同时运动,lock
    //    _scrollView.directionalLockEnabled = YES;
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    imageview.image = [UIImage imageNamed:_artTilte];
    [_scrollView addSubview:imageview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
