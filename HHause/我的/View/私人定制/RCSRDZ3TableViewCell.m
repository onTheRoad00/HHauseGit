//
//  RCSRDZ3TableViewCell.m
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSRDZ3TableViewCell.h"

@implementation RCSRDZ3TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)specialBtn:(id)sender {
    UIButton * btn = sender;
    btn.selected = !btn.selected;
    if (self.specialBlock) {
        self.specialBlock(btn.titleLabel.text);
    }
}
@end
