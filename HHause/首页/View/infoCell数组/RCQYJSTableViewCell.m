//
//  RCQYJSTableViewCell.m
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCQYJSTableViewCell.h"
#import "ZFChart.h"
@implementation RCQYJSTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showPieChart:(NSArray *)valueArray{
    CGRect  frame =CGRectMake(0, 0, kScreeWidth, self.MinorityRepresentationView.frame.size.height);
    ZFPieChart * pieChart = [[ZFPieChart alloc] initWithFrame:frame];
    
//    [pieChart setTranslatesAutoresizingMaskIntoConstraints:NO];
//    pieChart.frame = self.MinorityRepresentationView.frame;
    pieChart.title = @"族裔比例";
    pieChart.isShowPercent = NO;
    pieChart.isShadow = NO;
//    pieChart.valueArray = [NSMutableArray arrayWithObjects:valueArray, nil];
//    pieChart.valueArray = [NSMutableArray arrayWithObjects:@"27",@"24",@"7",@"33",@"9",nil];
    pieChart.valueArray =[NSMutableArray arrayWithArray:valueArray];
    pieChart.nameArray = [NSMutableArray arrayWithObjects:@"亚裔", @"白人",@"非裔",@"西班牙裔",@"其他族裔",nil];
    pieChart.colorArray = [NSMutableArray arrayWithObjects:ZFColor(254, 207, 96, 1), ZFColor(253, 131, 92, 1), ZFColor(134, 91, 178, 1), ZFColor(61, 163,232, 1), ZFColor(147, 207, 72, 1), nil];
    pieChart.percentType = kPercentTypeInteger;
    [self.MinorityRepresentationView addSubview:pieChart];
    [pieChart strokePath];
}
- (void)safe:(NSString *)cri{
    int crimes = [cri intValue];
    float percentage;
    if (crimes<100) {
        _safeLab.text = @"非常安全";
        percentage = 0;
    }else if (crimes>=100&&crimes<294)
    {
        _safeLab.text = @"很安全";
        percentage = 0.1;
    }else
    {
        _safeLab.text = @"安全";
        percentage = 0.2;
    }
    _safeView.transform =CGAffineTransformTranslate(_safeView.transform, -_safeBgView.frame.size.width * percentage, 0);
//    CGRect frame = _safeView.frame;
//    frame.size.width = _safeBgView.frame.size.width * percentage;
//    _safeView.frame = frame;
//    NSLog(@"%.f,%.f",_safeBgView.frame.size.width,_safeView.frame.size.width);
}
@end
