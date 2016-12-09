//
//  RCCheckHousePriceTableViewCell.m
//  HHause
//
//  Created by HHause on 2016/11/10.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCCheckHousePriceTableViewCell.h"

@implementation RCCheckHousePriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)creatBar:(NSArray*)dataAry{
    self.barChart.data = dataAry;
    self.barChart.barSpacing = 0;
    NSMutableArray * colorAry =[[NSMutableArray alloc]init];
    for (int i =0 ; i<self.barChart.data.count-1; i++) {
        [colorAry addObject:[UIColor colorWithRed:134/255.0 green:176/255.0 blue:220/255.0 alpha:1]];
    }
    [colorAry addObject:[UIColor colorWithRed:66/255.0 green:112/255.0 blue:191/255.0 alpha:1]];
    self.barChart.barColors = colorAry;
    self.barChart.backgroundColor = [UIColor whiteColor];
}

@end
