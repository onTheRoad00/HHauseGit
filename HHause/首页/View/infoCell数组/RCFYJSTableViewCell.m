//
//  RCFYJSTableViewCell.m
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCFYJSTableViewCell.h"

@implementation RCFYJSTableViewCell

- (void)awakeFromNib {
    _metric_ConversionsBtn.layer.borderColor = [UIColor colorWithRed:72.0/255 green:121.0/255 blue:206.0/255 alpha:1].CGColor;
    _metric_ConversionsBtn.layer.borderWidth = 1;
    _metric_ConversionsBtn.layer.masksToBounds = YES;
    _metric_ConversionsBtn.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)readmoreBtn:(id)sender {
    UIButton * btn = sender;
    
    if (self.btnBlock) {
        self.btnBlock(!btn.selected);
    }
    btn.selected = !btn.selected;
}
//block的实现部分
- (void)handlerButtonAction:(BTN)block
{
    self.btnBlock= block;
}
- (IBAction)metric_ConversionsBtn:(id)sender {
    _metric_ConversionsBtn.selected = !_metric_ConversionsBtn.selected;
    if (self.metic_ConversionBlock) {
    
        
            self.metic_ConversionBlock(_metric_ConversionsBtn.selected);
        
        
    }
}
@end
