//
//  RegisterViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/26.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "RegisterViewController.h"
#import <SVProgressHUD.h>
@interface RegisterViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"注册页面";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.neuedu.cn/register/register!turnToRegisterPage.action"]];
    self.webView.delegate = self;
    
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [SVProgressHUD dismiss];
}

#pragma mark - WebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

@end
