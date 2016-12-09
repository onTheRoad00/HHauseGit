//
//  RCHouseTableViewCell.m
//  HHause
//
//  Created by HHause on 16/5/4.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCHouseTableViewCell.h"

@implementation RCHouseTableViewCell

- (void)awakeFromNib {
    _houseImage.layer.cornerRadius = 4;
    _houseImage.layer.masksToBounds  = YES;
    // Initialization code
//    _bgView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.8];
//    _bgView.layer.cornerRadius = 8;
//    _bgView.layer.masksToBounds = YES;
//    CALayer *subLayer=[CALayer layer];
//    
//    CGRect fixframe=_bgView.layer.frame;
//    
////    fixframe.size.width=[UIScreen mainScreen].bounds.size.width-40;
//    
//    subLayer.frame=fixframe;
//    
//    subLayer.cornerRadius=8;
//    
//    subLayer.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1].CGColor;
//    
//    subLayer.masksToBounds=NO;
//    
//    subLayer.shadowColor=[UIColor redColor].CGColor;
//    
//    subLayer.shadowOffset=CGSizeMake(10,10);
//    
//    subLayer.shadowOpacity=1;
//    
//    subLayer.shadowRadius=8;
    
//    [self.layer insertSublayer:subLayer below:_bgView.layer];
//    [self.layer insertSublayer:_bgView.layer below:subLayer];
    
//    _bgView.layer.masksToBounds=NO;
     _bgView.layer.cornerRadius = 4;
    _bgView.layer.shadowColor=[UIColor grayColor].CGColor;
    
    _bgView.layer.shadowOffset=CGSizeMake(3,3);
    
    _bgView.layer.shadowOpacity=0.10;
    
    _bgView.layer.shadowRadius=4;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)IsMyFavorBtn:(id)sender {
    if (self.favBlock) {
        self.favBlock(_IsMyFavorBtn.selected);
    }
}
@end
