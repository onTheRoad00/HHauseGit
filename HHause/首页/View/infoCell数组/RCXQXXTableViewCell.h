//
//  RCXQXXTableViewCell.h
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCXQXXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLab;
@property (weak, nonatomic) IBOutlet UILabel *schoolTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;

@property (weak, nonatomic) IBOutlet UIView *bgview;
@end
