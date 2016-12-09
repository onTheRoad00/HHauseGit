//
//  RCSRDZ2TableViewCell.m
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSRDZ2TableViewCell.h"
@implementation RCSRDZ2TableViewCell
{
    UIWindow *window;
}
- (void)awakeFromNib {
    window=[[[UIApplication sharedApplication] delegate] window];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)firstBtn:(id)sender {
    CGPoint firstLabCGpoint = [_firstLab convertPoint:_firstLab.bounds.origin toView:window];
   firstLabCGpoint.y = firstLabCGpoint.y + self.bounds.size.height;
    NSLog(@"控件位置 yellow convertPoint:fromView: %@", NSStringFromCGPoint(firstLabCGpoint));
    _firstBtn.selected =!_firstBtn.selected;
    _secondBtn.selected =NO;
    if (self.firstBlock) {
        self.firstBlock(firstLabCGpoint,_firstBtn.selected);
    }
}
- (IBAction)secondBtn:(id)sender {
    CGPoint secondLabCGpoint = [_secondLab convertPoint:_secondLab.bounds.origin toView:window];
    secondLabCGpoint.y = secondLabCGpoint.y + self.bounds.size.height;
    NSLog(@"控件位置 yellow convertPoint:fromView: %@", NSStringFromCGPoint(secondLabCGpoint));
    
    _firstBtn.selected =NO;
    _secondBtn.selected =!_secondBtn.selected;
    if (self.secondBlock) {
        self.secondBlock(secondLabCGpoint,_secondBtn.selected);
    }
}
@end
