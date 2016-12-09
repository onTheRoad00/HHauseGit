//
//  RCQYJSTableViewCell.h
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCQYJSTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *percapitaIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *educationLab;
@property (weak, nonatomic) IBOutlet UILabel *population;
@property (weak, nonatomic) IBOutlet UILabel *UnemploymentLab;

@property (weak, nonatomic) IBOutlet UIView *safeBgView;
@property (weak, nonatomic) IBOutlet UIView *safeView;
@property (weak, nonatomic) IBOutlet UILabel *safeLab;

@property (weak, nonatomic) IBOutlet UIView *MinorityRepresentationView;

- (void)showPieChart:(NSArray *)valueArray;
- (void)safe:(NSString *)cri;
@end
