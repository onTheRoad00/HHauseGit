//
//  RCRegisterViewController.m
//  HHause
//
//  Created by HHause on 16/5/11.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCRegisterViewController.h"
#import "RCUtils.h"
@interface RCRegisterViewController ()<UITextFieldDelegate>
- (IBAction)cancelBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mobileNumTextField;
@property (weak, nonatomic) IBOutlet UIView *mobileNumView;

@property (weak, nonatomic) IBOutlet UITextField *AuthenticationTextField;
@property (weak, nonatomic) IBOutlet UIView *AuthenticationView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordView;


- (IBAction)registerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


- (IBAction)VerificationBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;

@end

@implementation RCRegisterViewController
{
    NSString * _type;
    BOOL  _AuthenticationBOOL;
    BOOL  _pwBOOL;
    BOOL _verificationBOOL;
    NSUserDefaults * ud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ud = [NSUserDefaults standardUserDefaults];
    _mobileNumTextField.delegate=self;
    _passwordTextField.delegate=self;
    _AuthenticationTextField.delegate=self;
    _verificationBOOL = NO;
    _AuthenticationBOOL = NO;
    _pwBOOL = NO;
    
    [_mobileNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_AuthenticationTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_registerBtn setTitle:_navtitle forState:UIControlStateNormal];
    if ([_navtitle isEqualToString:@"完成"]) {
        _passwordTextField.placeholder = @"请输入新密码（至少6位）"; 
    }else
    {
         _passwordTextField.placeholder = @"请输入密码（至少6位）";
    }
   
}
#pragma mark - TextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_mobileNumTextField resignFirstResponder];
    [_AuthenticationTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (([RCUtils checkTelNumber:_mobileNumTextField.text]||[RCUtils validateEmail:_mobileNumTextField.text])&&_passwordTextField.text.length>5&&_AuthenticationTextField.text.length>3)
        //验证手机号和邮箱_
    {
        _registerBtn.alpha = 1;
        _registerBtn.enabled = YES;
    }else
    {
        _registerBtn.alpha = 0.5;
        _registerBtn.enabled = NO;
    }
    if (([RCUtils checkTelNumber:_mobileNumTextField.text]||[RCUtils validateEmail:_mobileNumTextField.text])&&[_verificationBtn.titleLabel.text isEqualToString:@"获取验证码"]) {
        _verificationBtn.alpha = 1;
    }else{
        _verificationBtn.alpha = 0.5;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"Text field did begin editing");
    if ([textField isEqual:_mobileNumTextField]) {
        _mobileNumView.backgroundColor = KTextColor;
    }else if([textField isEqual:_passwordTextField]) {
        _passwordView.backgroundColor = KTextColor;
    }else if([textField isEqual:_AuthenticationTextField]) {
        _AuthenticationView.backgroundColor = KTextColor;
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"Text field ended editing");
    [_mobileNumTextField resignFirstResponder];
    [_AuthenticationTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    if ([textField isEqual:_mobileNumTextField]) {
        _mobileNumView.backgroundColor = [UIColor lightGrayColor];
        
    }else if([textField isEqual:_passwordTextField]) {
        _passwordView.backgroundColor = [UIColor lightGrayColor];

        
    }else if([textField isEqual:_AuthenticationTextField]) {
        _AuthenticationView.backgroundColor = [UIColor lightGrayColor];

    }
}

//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_mobileNumTextField resignFirstResponder];
    [_AuthenticationTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
#pragma mark-----------btn----------------
- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)registerBtn:(id)sender {
    [_mobileNumTextField resignFirstResponder];
    [_AuthenticationTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
//    NSLog(@"%f",_registerBtn.alpha);
    
//    if (![[NSString stringWithFormat:@"%.f",_registerBtn.alpha] isEqualToString:@"1"]) {
//         NSLog(@"%f",_registerBtn.alpha);
//        return;
//    }
    
    NSDictionary * registerDict =@{@"account":_mobileNumTextField.text,@"password":_passwordTextField.text,@"vcode":_AuthenticationTextField.text};
    NSString * url = KAPIAccount_register;
    if ([self.navtitle isEqualToString:@"完成"]) {
        url = KAPIAccount_reset_password;
    }
    [RCPOSTRequest requestWithUrl:url parameters:registerDict Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        if ([self.navtitle isEqualToString:@"完成"]) {
            if (dict[@"success"]) {
                [RCAlertView showMessage:@"修改成功"];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
//                //模态视图－－从3级退出到1级视图
//                if ([self respondsToSelector:@selector(presentingViewController)]){
//                    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
//                    }];
//                }
//                else {
//                
//                    [self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:^{
//                    }];
//                }
            }else if(dict[@"error"]){
                //            失败
                //            登录状态改变
                [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
                [RCAlertView showMessage:[NSString stringWithFormat:@"修改失败:%@",dict[@"error"][@"msg"]]];
            }
        }else{
//        NSLog(@"注册新用户--JSON: %@",dict);
        //注册成功
        if (dict[@"access_token"]) {
            //            解析
            
            //                保存  access_token,refresh_token;
            //                保存登录状态，name,头像
            //            保存access_token
            //            保存refresh_toker
            NSString * nickname =[NSString stringWithFormat:@"%@",dict[@"user"][@"nick"]];
            NSString * iconurl  =[NSString stringWithFormat:@"%@",dict[@"user"][@"avatar"]];
            
            
            [ud setObject:KKEYLogin_success forKey:KKEYLogin_successORdefeat];
            [ud setObject:nickname forKey:KKEYNickName];
            [ud setObject:iconurl forKey:KKEYHeadImageUrl];
            [ud setObject:dict[@"access_token"] forKey:KKEYAccess_token];
            [ud setObject:dict[@"refresh_token"] forKey:KKEYRefresh_token];
            
//            NSLog(@"\n\n\n\access_token:%@",dict[@"access_token"]);
//            NSLog(@"\n\n\n\refresh_token:%@",dict[@"refresh_token"]);
            
            [RCAlertView showMessage:@"登录成功"];
            //模态视图－－从3级退出到1级视图
            if ([self respondsToSelector:@selector(presentingViewController)]){
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
                }];
            }
            else {
                
                [self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:^{
                }];
            }
        }else if(dict[@"error"]){
            //            失败
            //            登录状态改变
            [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
            [RCAlertView showMessage:[NSString stringWithFormat:@"注册失败:%@",dict[@"error"][@"msg"]]];
            
            
        }
        }
        
    } faile:^(NSError *error) {
        
    }];
    
}

- (IBAction)VerificationBtn:(id)sender {
    [_mobileNumTextField resignFirstResponder];
    [_AuthenticationTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    if (_mobileNumTextField.text.length<1 || _mobileNumTextField == nil) {
        [RCAlertView showMessage:@"请输入手机号/邮箱"];
        return;
    }
    if ((![RCUtils checkTelNumber:_mobileNumTextField.text])&&(![RCUtils validateEmail:_mobileNumTextField.text]))
        //验证手机号和邮箱
    {
        [RCAlertView showMessage:@"手机号/邮箱输入有误，请重新输入"];
        return;
    }
    [self startTime];
    //发送验证码
    NSString * urlstr = [NSString stringWithFormat:@"%@?destination=%@",KAPIUtil_send_vcode,_mobileNumTextField.text];
    [RCGETRequest requestWithUrl:urlstr Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"验证码--JSON: %@",dict);
        if (dict[@"success"]) {
            _verificationBOOL = YES;
            [RCAlertView showMessage:@"发送成功,请注意查收"];
            if (_pwBOOL&&_AuthenticationBOOL&&_verificationBOOL) {
                _registerBtn.alpha = 1;
            }
            
        }else if(dict[@"error"]){
            //            失败
            [RCAlertView showMessage:[NSString stringWithFormat:@"发送失败:%@",dict[@"error"][@"msg"]]];
            
            
        }
        
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];
}
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _verificationBtn.userInteractionEnabled = YES;
                _verificationBtn.alpha = 1;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_verificationBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _verificationBtn.userInteractionEnabled = NO;
                _verificationBtn.alpha = 0.5;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
