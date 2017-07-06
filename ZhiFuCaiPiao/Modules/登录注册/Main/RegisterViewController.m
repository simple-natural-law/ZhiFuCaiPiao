//
//  RegisterViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/4.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField *_activeTextField;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_activeTextField)
    {
        [_activeTextField resignFirstResponder];
    }
}


#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.passwordTextField)
    {
        [self.againPasswordTextField becomeFirstResponder];
    }else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeTextField = nil;
}


- (IBAction)registerUser:(id)sender
{
    if (![self.userNameTextField.text checkUserName])
    {
        [self showHint:@"账号只能由数字,字母和下划线组成"];
        return;
    }
    
    if (![self.passwordTextField.text checkUserName])
    {
        [self showHint:@"密码只能由数字,字母和下划线组成"];
        return;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.againPasswordTextField.text])
    {
        [self showHint:@"两次输入密码不一致"];
        return;
    }
    
    [self showHUDWithStatus:@"注册并登录"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideHUD];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_activeTextField)
    {
        [_activeTextField resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
