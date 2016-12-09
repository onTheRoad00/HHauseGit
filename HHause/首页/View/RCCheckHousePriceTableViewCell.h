//
//  RCCheckHousePriceTableViewCell.h
//  HHause
//
//  Created by HHause on 2016/11/10.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEABarChart.h"

@interface RCCheckHousePriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dataTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *rateLab;

-(void)creatBar:(NSArray*)dataAry;
@property (weak, nonatomic) IBOutlet TEABarChart *barChart;

@end
