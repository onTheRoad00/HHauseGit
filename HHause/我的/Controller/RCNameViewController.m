//
//  RCNameViewController.m
//  HHause
//
//  Created by HHause on 16/5/12.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCNameViewController.h"

@interface RCNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RCNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.delegate=self;
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, _textField.frame.size.height)];
    _textField.leftView=view;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - TextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder]; 
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"Text field did begin editing");
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"Text field ended editing");
//    NSLog(@"textfield:%@",textField.text);
    
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:textField.text forKey:@"name"];
}

//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_textField resignFirstResponder];
}
@end
