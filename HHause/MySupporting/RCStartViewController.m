//
//  RCStartViewController.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//第一次登陆，新手导航
//
#import "RCStartViewController.h"

@interface RCStartViewController ()

@end

@implementation RCStartViewController
{
    UIScrollView * _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3, [UIScreen mainScreen].bounds.size.height );
    [self.view addSubview:_scrollView];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO ;
  
    _scrollView.userInteractionEnabled = YES;
    for (int  i = 0; i < 3 ; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imageView .userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        //图片名字
        NSString * str = [NSString stringWithFormat:@"start_%d.png",i+1];
        imageView.image = [UIImage imageNamed:str];
        if (i==2) {
//            NSLog(@"%f",500*kScreeHeight/667);
            UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame = CGRectMake(0,550*kScreeHeight/667,kScreeWidth, 100*kScreeHeight/667);
            [button setTitle:@"" forState:(UIControlStateNormal)];
            [imageView addSubview:button];
//            button.backgroundColor = KTextColor;
//            button.titleLabel.textColor = [UIColor whiteColor];
            [button addTarget:self action:@selector(start:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) start:(id)sender{
    if (_start) {
        _start();
        
    }
}

@end
