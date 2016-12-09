//
//  RCSRDZ4TableViewCell.m
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSRDZ4TableViewCell.h"
@interface RCSRDZ4TableViewCell ()<UITextFieldDelegate>
@end
@implementation RCSRDZ4TableViewCell

- (void)awakeFromNib {
    _textField.delegate = self;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
}
- (void)tongzhi:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"通知"]);
    if ([text.userInfo[@"通知"] isEqualToString:@"resignFirstResponder"]) {
        [_textField resignFirstResponder];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -------------------- textField   delegate------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
    if (self.beginBlock) {
        self.beginBlock(@"beginEditing");
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
        NSLog(@"Text field ended editing");
    if (self.endBlock) {
        self.endBlock(@"endEditing");
    }
}

@end
