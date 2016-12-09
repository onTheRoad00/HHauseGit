//
//  RCQuestionViewController.m
//  HHause
//
//  Created by HHause on 16/6/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCQuestionViewController.h"

@interface RCQuestionViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)backBtn:(id)sender;
- (IBAction)sendBtn:(id)sender;

@end

@implementation RCQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    _textView.layer.borderWidth = 1;
//    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--------textView---------------------------------
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入反馈信息."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        _textView.layer.borderColor = KTextColor.CGColor;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
     _textView.layer.borderColor = [UIColor grayColor].CGColor;
    if (textView.text.length<1) {
        textView.text = @"请输入反馈信息.";
        textView.textColor = [UIColor lightGrayColor];
    }
}

//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    
    [_textView resignFirstResponder];
    
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendBtn:(id)sender {
    [_textView resignFirstResponder];
    if (_textView== nil||_textView.text.length<1||[_textView.text isEqualToString:@"请输入反馈信息."]) {
        [RCAlertView showMessage:@"反馈信息不能为空"];
    }
    else
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary * deedbackDict =@{@"content":_textView.text,@"access_token":[ud valueForKey:KKEYAccess_token]};
        [RCPOSTRequest requestWithUrl:KAPIFEEDBACK parameters:deedbackDict Complete:^(NSData *data) {
            //返回数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//            NSLog(@"第三方验证--JSON: %@",dict);
            //提交成功
         [RCAlertView showMessage:@"反馈成功，亲耐心等待我们的消息"];
     [self.navigationController popViewControllerAnimated:YES];
        } faile:^(NSError *error) {
            
        }];

        
    }

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
@end
