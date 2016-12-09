//
//  RCPassWordViewController.m
//  HHause
//
//  Created by HHause on 16/5/12.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCPassWordViewController.h"
#import "RCUtils.h"
@interface RCPassWordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldpwTextfield;
@property (weak, nonatomic) IBOutlet UIView *oldpwView;

@property (weak, nonatomic) IBOutlet UITextField *newpwTextfield;
@property (weak, nonatomic) IBOutlet UIView *newpwView;

@property (weak, nonatomic) IBOutlet UITextField *repeatTextfield;
@property (weak, nonatomic) IBOutlet UIView *repeatView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submitBtn:(id)sender;
- (IBAction)backBtn:(id)sender;

@end

@implementation RCPassWordViewController
{
    NSUserDefaults * ud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _oldpwTextfield.delegate=self;
    _newpwTextfield.delegate=self;
    _repeatTextfield.delegate=self;
    ud = [NSUserDefaults standardUserDefaults];
    [ _oldpwTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_newpwTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_repeatTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (_oldpwTextfield.text.length>5&&_newpwTextfield.text.length>5&&[_repeatTextfield.text isEqualToString:_newpwTextfield.text])
        
    {
        _submitBtn.alpha = 1;
        _submitBtn.enabled = YES;
    }else
    {
        _submitBtn.alpha = 0.5;
        _submitBtn.enabled = NO;
    }
}

#pragma mark - TextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_oldpwTextfield resignFirstResponder];
    [_newpwTextfield resignFirstResponder];
    [_repeatTextfield resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"Text field did begin editing");
    if ([textField isEqual:_oldpwTextfield]) {
        _oldpwView.backgroundColor = KTextColor;
    }else if([textField isEqual:_newpwTextfield]) {
        _newpwView.backgroundColor = KTextColor;
    }else if([textField isEqual:_repeatTextfield]) {
        _repeatView.backgroundColor = KTextColor;
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"Text field ended editing");
    if ([textField isEqual:_oldpwTextfield]) {
        _oldpwView.backgroundColor = [UIColor lightGrayColor];
    }else if([textField isEqual:_newpwTextfield]) {
        _newpwView.backgroundColor = [UIColor lightGrayColor];
    }else if([textField isEqual:_repeatTextfield]) {
        _repeatView.backgroundColor = [UIColor lightGrayColor];
    }
}
//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_oldpwTextfield resignFirstResponder];
    [_newpwTextfield resignFirstResponder];
    [_repeatTextfield resignFirstResponder];
    
}

- (IBAction)submitBtn:(id)sender {
    [_oldpwTextfield resignFirstResponder];
    [_newpwTextfield resignFirstResponder];
    [_repeatTextfield resignFirstResponder];
    NSDictionary * updateDict =@{@"old_password":_oldpwTextfield.text,@"new_password":_newpwTextfield.text};
    NSString * urlstr = [NSString stringWithFormat:@"%@?access_token=%@",KAPIAccount_update_password,[ud valueForKey:KKEYAccess_token]];
    [RCPOSTRequest requestWithUrl:urlstr parameters:updateDict Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"修改密码-JSON: %@",dict);
        //注册成功
        if (dict[@"success"]) {
            
            [RCAlertView showMessage:@"修改成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self exit];
        }else if(dict[@"error"]){
            //            失败
            //            登陆状态改变

            [RCAlertView showMessage:[NSString stringWithFormat:@"修改失败:%@",dict[@"error"][@"msg"]]];
            
            
        }
        
        
    } faile:^(NSError *error) {
        
    }];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
//退出
-(void)exit{
    
    [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
    [ud removeObjectForKey:KKEYHeadImageUrl];
    [ud removeObjectForKey:KKEYNickName];
    [ud removeObjectForKey:KKEYRefresh_token];
    [ud removeObjectForKey:KKEYAccess_token];
}
@end
