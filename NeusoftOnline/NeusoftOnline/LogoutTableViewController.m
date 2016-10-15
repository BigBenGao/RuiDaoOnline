//
//  LogoutTableViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/10/12.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "LogoutTableViewController.h"
#import "ViewController.h"
#import "MYAFNetWork.h"
#import <SVProgressHUD.h>

extern NSString *SScore;
@interface LogoutTableViewController ()
@property(nonatomic,strong) UIButton *logoutButton;
@end

@implementation LogoutTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    if(self.score != 0)
    {
        [self.tableView reloadData];
    }
}

-(UIButton *)logoutButton
{
    if(!_logoutButton)
    {
        _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 200, self.view.frame.size.width - 40, 40)];
        [_logoutButton setTitle:@"退 出" forState:UIControlStateNormal];
        [_logoutButton setBackgroundColor:[UIColor blueColor]];
        [_logoutButton addTarget:self action:@selector(userLogout) forControlEvents:UIControlEventTouchUpInside];
         _logoutButton.layer.cornerRadius = 5;
    }
    return _logoutButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    

    [self.view addSubview:self.logoutButton];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.tableView.backgroundColor = [UIColor redColor];
}
-(void)userLogout
{
    [MYAFNetWork POST:@"http://www.neuedu.cn/m/mobileLogout!logoutNeu.action" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *judge = responseObject[@"logoutReturn"][@"logoutFlag"];
        [SVProgressHUD showInfoWithStatus:@"正在退出"];
        if (judge.integerValue == 1)
        {
            NSLog(@"退出成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = sb.instantiateInitialViewController;
                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable resk, NSError * _Nonnull error)
     {
        NSLog(@"%@",error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"分数:%ld",self.score];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
