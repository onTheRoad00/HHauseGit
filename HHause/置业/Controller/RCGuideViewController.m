//
//  RCGuideViewController.m
//  HHause
//
//  Created by HHause on 16/5/4.
//  Copyright © 2016年 HHause. All rights reserved.
//指南

#import "RCGuideViewController.h"
#import "RCHousePurchasingTableViewCell.h"
#import "RCArticleViewController.h"
#import "ReadManager.h"
#import "RCGuide2ViewController.h"
#define Identifier1 @"RCHousePurchasingTableViewCell"
@interface RCGuideViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RCGuideViewController
{
    NSArray * _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=156*kScreeWidth/375;
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UINib * nib=[UINib nibWithNibName:Identifier1 bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:Identifier1];
    
    _array = @[@[@"政策对比",@"美国房产永久产权,交易费用低,购房过程严格监管,保障权益",@"http://mp.weixin.qq.com/s?__biz=MzI0MTIyOTAxMg==&mid=100000040&idx=1&sn=4e3f9b98210a437518d3f6c8a73cc865&scene=18#wechat_redirect",@"guide0.png"],
               @[@"流程对比",@"让买房卖房的流程更加透明化",@"http://mp.weixin.qq.com/s?__biz=MzI0MTIyOTAxMg==&mid=100000130&idx=1&sn=c72c286fbf4c408f5bb3ee555a07dd1a&scene=18#wechat_redirect",@"guide1.png"],
               @[@"房价对比",@"中美两地房价对比让您优惠购房，放心购房",@"http://mp.weixin.qq.com/s?__biz=MzI0MTIyOTAxMg==&mid=100000133&idx=1&sn=540cd4f4c05e94dd493c09ee8e3b32b3&scene=18#wechat_redirect",@"guide2.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark--------------------------------Appear--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    
}

#pragma ----------tableview-----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCHousePurchasingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier1 forIndexPath:indexPath];
    cell.titleLab.text = _array[indexPath.row][0];
    cell.desLAv.text = _array[indexPath.row][1];
    cell.leftImage.image = [UIImage imageNamed:_array[indexPath.row][3]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RCArticleViewController * article = [[RCArticleViewController alloc]init];
//    article.mytitle = @"置业指南";
//    
//    article.urlstring = _array[indexPath.row][2];
//    article.summary = _array[indexPath.row][1];
//    article.arttitle = _array[indexPath.row][0];
//    article.imageName = _array[indexPath.row][3];
//    [[ReadManager share].vc presentViewController:article animated:YES completion:^{
//        
//    }];
    
    RCGuide2ViewController * guide2 = [[RCGuide2ViewController alloc]init];
   
    guide2.artTilte = _array[indexPath.row][0];
    
        [[ReadManager share].vc presentViewController:guide2 animated:YES completion:^{
    
        }];
}

@end
