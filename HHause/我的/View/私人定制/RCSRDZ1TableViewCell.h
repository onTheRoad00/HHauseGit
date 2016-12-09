//
//  RCSRDZ1TableViewCell.h
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSRDZ1TableViewCell : UITableViewCell
typedef void(^INTENTION)(NSString *intention);
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *schoolHouseBtn;
@property (weak, nonatomic) IBOutlet UIButton *investmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *luxuryBtn;
@property (nonatomic,copy) INTENTION intentionBlock;
@end
