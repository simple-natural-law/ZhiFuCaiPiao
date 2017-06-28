//
//  BaseWebViewController.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/27.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@property (nonatomic, strong) UIProgressView *progressView;

@end


@implementation BaseWebViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.canSelectContent = NO;
    self.showWebTitleToNavigationTitle = NO;
    self.isShowHUD = YES;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark-
- (void)loadWebView:(UIWebView *)webView URL:(NSURL *)URL param:(NSDictionary *)param
{
    _webview = webView;
    
    self.param = param;
    
    if (_webview == nil)
    {
        _webview = [[UIWebView alloc]init];
        _webview.translatesAutoresizingMaskIntoConstraints = NO;
        _webview.delegate = self;
        [self.view addSubview:_webview];
        NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
        NSLayoutConstraint *trailingCons = [NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        [self.view addConstraints:@[topCons,leadingCons,trailingCons,bottomCons]];
    }
    
    if (self.isShowHUD)
    {
        [self showHUDWithStatus:@"加载中"];
    }
    
    [_webview loadRequest:[NSURLRequest requestWithURL:URL]];
}


- (void)loadURL:(NSURL *)URL param:(NSDictionary *)param
{
    [self loadWebView:nil URL:URL param:param];
}


#pragma mark-
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.isShowHUD)
    {
        [self hideHUD];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (self.isShowHUD)
    {
        [self hideHUD];
    }
    [self showHint:error.description];
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
