//
//  RCWikiViewController.m
//  HHause
//
//  Created by HHause on 16/8/30.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCWikiViewController.h"
#import "RCArtcleListViewController.h"
#import "RCRaidersViewController.h"
#import "RCGuideViewController.h"
#import "RCLifeAbroadViewController.h"
//分页侧滑
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "ReadManager.h"
@interface RCWikiViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;

@end

@implementation RCWikiViewController
{
    RCArtcleListViewController * artclelist;
    NSArray * array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSegment];
    [self initFlipTableView];
    
    [ReadManager share].vc = self;
    array = @[@"置业指南",@"置业攻略",@"海外生活",@"问答"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, kScreeWidth, 44) withDataArray:[NSArray arrayWithObjects:@"指南",@"攻略",@"生活",@"问答", nil] withFont:14];
    self.segment.delegate = self;
    self.segment.textSelectedColor = KTextColor;
    self.segment.textNomalColor = KGaryColor;
    self.segment.lineColor = KTextColor;
    [self.view addSubview:self.segment];
}
-(void)initFlipTableView{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    artclelist = [[RCArtcleListViewController alloc]init];
    [self.controllsArray addObjectsFromArray:@[[[RCGuideViewController alloc] init],[[RCRaidersViewController alloc]init],[[RCLifeAbroadViewController alloc]init],artclelist]];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 108, kScreeWidth, kScreeHeight-108 ) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    
    [self.flipView selectIndex:index];
    
}
-(void)scrollChangeToIndex:(NSInteger)index
{
    
    
    [self.segment selectIndex:index];
}


@end
