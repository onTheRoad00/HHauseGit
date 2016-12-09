//
//  RCSelectCityViewController.h
//  HHause
//
//  Created by HHause on 16/5/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CITY)(NSString *type);

@interface RCSelectCityViewController : UIViewController
@property (nonatomic,strong)CITY  cityBlock;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
