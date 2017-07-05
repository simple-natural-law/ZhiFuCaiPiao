//
//  LoginViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/4.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

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


- (IBAction)goRegisterVC:(id)sender
{
    [self pushViewControllerKey:@"RegisterViewController" param:nil animated:YES];
}


- (IBAction)login:(id)sender
{
    
}


- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
