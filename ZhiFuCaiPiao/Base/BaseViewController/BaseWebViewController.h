//
//  BaseWebViewController.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/27.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>


@interface BaseWebViewController : BaseViewController

@property (strong, nonatomic) WKWebView *webview;

// 是否允许用户选择页面内容,默认NO
@property (assign, nonatomic) BOOL canSelectContent;

// 如果存在,显示网页标题到导航栏,默认NO
@property (assign, nonatomic) BOOL showWebTitleToNavigationTitle;

// 是否显示活动指示器,默认yes
@property (assign, nonatomic) BOOL isShowHUD;


- (void)loadURL:(NSURL *)URL param:(NSDictionary *)param;
- (void)loadWebView:(UIWebView *)webView URL:(NSURL *)URL param:(NSDictionary *)param;

@end
