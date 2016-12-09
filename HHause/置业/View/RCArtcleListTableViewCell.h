//
//  RCArtcleListTableViewCell.h
//  HHause
//
//  Created by HHause on 16/6/8.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCArtcleListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *pvLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
