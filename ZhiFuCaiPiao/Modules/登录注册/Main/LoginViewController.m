//
//  LoginViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/4.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *_activeTextField;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAndSetLeftButtonWithTitle:@"取消" touchUpInsideAction:@selector(back)];
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
    [textField resignFirstResponder];
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

- (IBAction)goRegisterVC:(id)sender
{
    [self pushViewControllerKey:@"RegisterViewController" param:nil animated:YES];
}


- (IBAction)login:(id)sender
{
    if (![self.userNameTextField.text isChinaMobileNumber])
    {
        [self showHint:@"请输入正确的手机号码"];
        return;
    }
    
    if (![self.passwordTextField.text checkUserName])
    {
        [self showHint:@"密码只能由数字,字母和下划线组成"];
        return;
    }
    
    [self showHUDWithStatus:@"登录中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideHUD];
        
        [self back];
    });
}


- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
