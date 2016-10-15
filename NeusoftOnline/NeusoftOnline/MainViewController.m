//
//  MainViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

static int i = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    i = 0;
    [self addChildController:@"StudyOnlineViewController" andTitle:@"在线学习"];
    [self addChildController:@"OnlineTestViewController"  andTitle:@"在线测试"];
    [self addChildController:@"LogoutTableViewController" andTitle:@"我"];
}

-(void)addChildController:(NSString *)viewControllerName andTitle:(NSString *)title
{
    
    UITableViewController *vc = [[NSClassFromString(viewControllerName) alloc] init];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar%d",i++]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
