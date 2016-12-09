//
//  RCSRDZ1TableViewCell.m
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSRDZ1TableViewCell.h"

@implementation RCSRDZ1TableViewCell

- (void)awakeFromNib {
    _schoolHouseBtn.layer.borderWidth = 1;
    _schoolHouseBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _schoolHouseBtn.layer.masksToBounds = YES;
    _schoolHouseBtn.layer.cornerRadius = 5.0;
    
    _investmentBtn.layer.borderWidth = 1;
    _investmentBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _investmentBtn.layer.masksToBounds = YES;
    _investmentBtn.layer.cornerRadius = 5.0;
    
    _luxuryBtn.layer.borderWidth = 1;
    _luxuryBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _luxuryBtn.layer.masksToBounds = YES;
    _luxuryBtn.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btn:(id)sender {
    UIButton * btn =sender;
    if ([btn isEqual:_schoolHouseBtn]) {
        
        _schoolHouseBtn.backgroundColor = KTextColor;
        [_schoolHouseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _investmentBtn.backgroundColor = [UIColor whiteColor];
        [_investmentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        _luxuryBtn.backgroundColor = [UIColor whiteColor];
        [_luxuryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else if([btn isEqual:_investmentBtn]) {
        
        _schoolHouseBtn.backgroundColor = [UIColor whiteColor];
        [_schoolHouseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        _investmentBtn.backgroundColor = KTextColor;
        [_investmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _luxuryBtn.backgroundColor = [UIColor whiteColor];
        [_luxuryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else if([btn isEqual:_luxuryBtn]) {
        
        _schoolHouseBtn.backgroundColor = [UIColor whiteColor];
        [_schoolHouseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        _investmentBtn.backgroundColor = [UIColor whiteColor];
       [_investmentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        _luxuryBtn.backgroundColor = KTextColor;
       [_luxuryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if (self.intentionBlock) {
        self.intentionBlock(btn.titleLabel.text);
    }
}
@end
