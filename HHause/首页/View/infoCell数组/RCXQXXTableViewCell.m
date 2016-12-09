//
//  RCXQXXTableViewCell.m
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCXQXXTableViewCell.h"

@implementation RCXQXXTableViewCell


- (void)awakeFromNib {
    _scoreLab.layer.cornerRadius = _scoreLab.frame.size.width/2;
    _scoreLab.layer.masksToBounds = YES;
    
    _bgview.layer.cornerRadius = 27;
    _bgview.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
