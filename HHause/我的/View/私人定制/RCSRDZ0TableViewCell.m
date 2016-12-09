//
//  RCSRDZ0TableViewCell.m
//  私人订制Demo
//
//  Created by HHause on 16/7/1.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSRDZ0TableViewCell.h"
#import "CJCalendarViewController.h"
#import "RCSManager.h"
@interface RCSRDZ0TableViewCell ()<CalendarViewControllerDelegate>
@end
@implementation RCSRDZ0TableViewCell
{
    CJCalendarViewController *calendarController;
}
- (void)awakeFromNib {
    self.startBtn.layer.borderWidth = 1;
    self.startBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.startBtn.layer.masksToBounds = YES;
    self.startBtn.layer.cornerRadius = 5.0;
    self.endBtn.layer.borderWidth = 1;
    self.endBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.endBtn.layer.masksToBounds = YES;
    self.endBtn.layer.cornerRadius = 5.0;
    
    calendarController = [[CJCalendarViewController alloc] init];
    calendarController.view.frame = [RCSManager sshare].vc.view.frame;
    
    calendarController.headerBackgroundColor = KTextColor;
    calendarController.contentBackgroundColor = KTextColor;
    
    
    calendarController.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startBtn:(id)sender {
   
    self.startBtn.selected = YES;
    self.endBtn.selected = NO;
    NSLog(@"%@",self.startBtn.titleLabel.text);
     [[RCSManager sshare].vc presentViewController:calendarController animated:YES completion:nil];
}

- (IBAction)endBtn:(id)sender {
   
    self.startBtn.selected = NO;
    self.endBtn.selected = YES;
     [[RCSManager sshare].vc presentViewController:calendarController animated:YES completion:nil];
}
-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString * type;
    if (self.startBtn.selected) {
        [self.startBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@", year, month, day] forState:UIControlStateNormal];
        self.startBtn.selected = NO;
        type = @"start";
    }
    else if(self.endBtn.selected)
    {
         [self.endBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@", year, month, day] forState:UIControlStateNormal];
        self.endBtn.selected = NO;
        type = @"end";
    }
    if (self.timeBlock) {
        self.timeBlock(type,[NSString stringWithFormat:@"%@-%@-%@", year, month, day]);
    }
}

@end
