//
//  RCSRDZ2TableViewCell.h
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BTN)(CGPoint point,BOOL select);
@interface RCSRDZ2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
- (IBAction)firstBtn:(id)sender;

@property (nonatomic,copy) BTN firstBlock;
@property (nonatomic,copy) BTN secondBlock;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
- (IBAction)secondBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@end
