//
//  ViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/26.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "ViewController.h"
#import "MYAFNetWork.h"
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>
#import "MainViewController.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UITextField *checkTextField;

@end

@implementation ViewController

-(UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        _pageControl.frame = CGRectMake(self.view.frame.size.width / 2 - 50,
                                        self.view.frame.size.height - 37, 100, 37);
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

-(void)loadGuide
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    for(int i = 0 ; i < 3; ++i)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        imageView.frame = CGRectMake(i * width, 0, width, height);
        [self.scrollView addSubview:imageView];
    }
}

-(BOOL)shouldLoadGuide
{
    NSString *info = [[NSUserDefaults standardUserDefaults] objectForKey:@"appInfo"];
    NSString *VersonInfo = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (info != VersonInfo)
    {
        [self loadGuide];
        [[NSUserDefaults standardUserDefaults] setObject:VersonInfo forKey:@"appInfo"];
        return YES;
    }
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self shouldLoadGuide];
  
    [self loadCheckImageView];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.accountTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];;
    self.passWordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwd"];;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
}

/**加载验证码*/
-(void)loadCheckImageView
{
    self.checkImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadCheckImage)];
    doubleTap.numberOfTapsRequired = 2;
    [self.checkImageView addGestureRecognizer:doubleTap];

    [self reloadCheckImage];
}

/**刷新验证码*/
-(void)reloadCheckImage
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString: @"http://www.neuedu.cn/imgcode"]  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.checkImageView.image = [UIImage imageWithData:data];
        });
    }];
    
    [task resume];
}

- (IBAction)login:(UIButton *)sender
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"username"] = self.accountTextField.text;
    param[@"pwd"] = self.passWordTextField.text;
    param[@"imgcode"] = self.checkTextField.text;
    
    [SVProgressHUD showWithStatus:@"正在登录"];
    
    [MYAFNetWork POST:@"http://www.neuedu.cn/m/mobileLogin!loginNeu.action" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSString *flag = (NSString *)responseObject[@"loginReturn"][@"loginFlag"];
         if (flag.integerValue == 0)
         {
             NSLog(@"%@",responseObject[@"loginReturn"][@"msg"]);
             [SVProgressHUD showInfoWithStatus:responseObject[@"loginReturn"][@"msg"]];
             [self reloadCheckImage];
         }
         else
         {
             [[NSUserDefaults standardUserDefaults] setValue:self.accountTextField.text forKey:@"account"];
             [[NSUserDefaults standardUserDefaults] setValue:self.passWordTextField.text forKey:@"passwd"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [UIApplication sharedApplication].keyWindow.rootViewController = [[MainViewController alloc] init];
             [SVProgressHUD dismiss];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable resk, NSError * _Nonnull error) {
         [SVProgressHUD showInfoWithStatus:error.localizedDescription];
     }];
}

#pragma mark - scrollViewDeledate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.pageControl.currentPage == 2)
    {
            [self.scrollView removeFromSuperview];
            [self.pageControl removeFromSuperview];
    }
    NSInteger page = scrollView.contentOffset.x / self.view.frame.size.width;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
