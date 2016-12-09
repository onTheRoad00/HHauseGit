//
//  RCIndexBtnTableViewCell.m
//  HHause
//
//  Created by HHause on 16/5/22.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCIndexBtnTableViewCell.h"

@implementation RCIndexBtnTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SchoolEstate:(id)sender {
    UIButton * btn = sender;
    if (self.btnBlock) {
        self.btnBlock(btn.titleLabel.text);
    }

}
@end
