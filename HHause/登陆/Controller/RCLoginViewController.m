//
//  RCLoginViewController.m
//  HHause
//
//  Created by HHause on 16/5/11.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCLoginViewController.h"
#import "RCRegisterViewController.h"
#import "RCUtils.h"
// 导入头文件
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
//#define  blueColor [UIColor colorWithRed:69/255.0 green:114/255.0 blue:188/255.0 alpha:1]
@interface RCLoginViewController ()<UITextFieldDelegate>
- (IBAction)cancelBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mobileNumView;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumTextField;
@property (weak, nonatomic) IBOutlet UIView *passworeView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)loginBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBn;

- (IBAction)weixinBtn:(id)sender;

- (IBAction)registerBtn:(id)sender;
- (IBAction)forgetPasswordBtn:(id)sender;

@end

@implementation RCLoginViewController
{
     NSUserDefaults * ud;
    RCRegisterViewController * _register;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _register =[[RCRegisterViewController alloc]init];
    
    
    
    _mobileNumTextField.delegate=self;
    _passwordTextField.delegate=self;
    
     ud = [NSUserDefaults standardUserDefaults];
    [_mobileNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - TextField Delegates---------------
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (([RCUtils checkTelNumber:_mobileNumTextField.text]||[RCUtils validateEmail:_mobileNumTextField.text])&&_passwordTextField.text.length>5)
        //验证手机号和邮箱
    {
        _loginBn.alpha = 1;
        _loginBn.enabled = YES;
    }else
    {
         _loginBn.alpha = 0.5;
        _loginBn.enabled = NO;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_passwordTextField resignFirstResponder];
    [_mobileNumTextField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"Text field did begin editing");
    if ([textField isEqual:_mobileNumTextField]) {
        _mobileNumView.backgroundColor = KTextColor;
    }else if([textField isEqual:_passwordTextField]) {
        _passworeView.backgroundColor = KTextColor;
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"Text field ended editing");
    if ([textField isEqual:_mobileNumTextField]) {
        _mobileNumView.backgroundColor = [UIColor lightGrayColor];
    }else if([textField isEqual:_passwordTextField]) {
        _passworeView.backgroundColor = [UIColor lightGrayColor];
    }
}

//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_passwordTextField resignFirstResponder];
    [_mobileNumTextField resignFirstResponder];
}

#pragma mark-----------btn----------------

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)loginBtn:(id)sender {
    [_mobileNumTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
//    if (_mobileNumTextField.text.length<11 || _mobileNumTextField == nil) {
//        [RCAlertView showMessage:@"手机号少于11位，请重新输入"];
//        return;
//    }
//    if (![RCUtils checkTelNumber:_mobileNumTextField.text])  //匹配结果,为YES
//    {
//       [RCAlertView showMessage:@"手机号格式错误，请重新输入"];
//        return;
//    }
//    
//    //密码验证
//    if (_passwordTextField.text.length<6 || _passwordTextField == nil) {
//        [RCAlertView showMessage:@"密码错误，请重新输入"];
//        return;
//    }
    NSDictionary * loginDict =@{@"account":_mobileNumTextField.text,@"password":_passwordTextField.text};
    [RCPOSTRequest requestWithUrl:KAPIAccount_login parameters:loginDict Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"登录--JSON: %@",dict);
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
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }else if(dict[@"error"]){
            //            失败
            //            登录状态改变
            [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
            [RCAlertView showMessage:[NSString stringWithFormat:@"登录失败:%@",dict[@"error"][@"msg"]]];
            
            
        }
        
        
    } faile:^(NSError *error) {
        //            失败
        //            登录状态改变
        [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
        [RCAlertView showMessage:@"登录失败"];
    }];
}

- (IBAction)weixinBtn:(id)sender {
    SSDKPlatformType  SSDKPlat=SSDKPlatformTypeWechat ;
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
        //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
        //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
        associateHandler (user.uid, user, user);
//        NSLog(@"dd%@\n\n\n%@\n%@",user.rawData,user.credential,user.credential.token);
//        NSLog(@"user.uid= %@",user.uid);
#pragma ----------------------
        //第三方登录验证
        NSDictionary * authDict =@{@"out_uid":user.uid,@"token":user.credential.token,@"type":@"1"};
        [RCPOSTRequest requestWithUrl:KAPIAUTHORIZE parameters:authDict Complete:^(NSData *data) {
            //返回数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//            NSLog(@"第三方验证--JSON: %@",dict);
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
                
//                NSLog(@"\n\n\n\access_token:%@",dict[@"access_token"]);
//                NSLog(@"\n\n\n\refresh_token:%@",dict[@"refresh_token"]);
                
                [RCAlertView showMessage:@"登录成功"];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];

            }else if(dict[@"error"]){
                //            失败
                //            登录状态改变
                [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
                [RCAlertView showMessage:@"登录失败"];
              

            }
            
            
        } faile:^(NSError *error) {
            //            失败
            //            登录状态改变
//            NSLog(@"%@",error);
            [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
            [RCAlertView showMessage:@"登录失败"];
        }];
        
    }
        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error)
     {
         
         if (state == SSDKResponseStateSuccess)
         {
             
         }
     }];

}

- (IBAction)registerBtn:(id)sender {
    _register.navtitle=@"注册";
    _register.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:_register animated:YES completion:^{
        
    }];
}

- (IBAction)forgetPasswordBtn:(id)sender {
    _register.navtitle=@"完成";
    _register.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:_register animated:YES completion:^{
        
    }];
}
- (void)dealloc
{
//    NSLog(@"\n\t\n\t\n\t 登录 释放了\n\t\n\t\n\t");
}
@end
