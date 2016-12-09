//
//  RCNavigationController.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCNavigationController.h"

@interface RCNavigationController ()

@end

@implementation RCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigation的translucent属性为no
    self.navigationBar.barTintColor = KColor;
//    self.navigationBar.tintColor = [UIColor grayColor];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.navigationBar.backgroundColor = [UIColor grayColor];
    
    
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

@end
