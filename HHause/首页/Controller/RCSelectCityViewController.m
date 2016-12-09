//
//  RCSelectCityViewController.m
//  HHause
//
//  Created by HHause on 16/5/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSelectCityViewController.h"
@interface RCSelectCityViewController ()<UITableViewDelegate,UITableViewDataSource>
- (IBAction)cancel:(id)sender;

@end

@implementation RCSelectCityViewController
{
    NSArray * _citysAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;

    _citysAry = @[@"不限",@"旧金山",@"西雅图",@"洛杉矶"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma ----------tableview-----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _citysAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.textLabel.text=_citysAry[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cityBlock) {
        self.cityBlock(_citysAry[indexPath.row]);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
