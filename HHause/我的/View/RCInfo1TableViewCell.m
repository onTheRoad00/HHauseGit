//
//  RCInfo1TableViewCell.m
//  HHause
//
//  Created by HHause on 16/5/12.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCInfo1TableViewCell.h"

@implementation RCInfo1TableViewCell

- (void)awakeFromNib {
    _headImage.layer.masksToBounds=YES;
    _headImage.layer.cornerRadius =_headImage.frame.size.width*0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
