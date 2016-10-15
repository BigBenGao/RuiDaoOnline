//
//  StudyOnlineViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "StudyOnlineViewController.h"
#import <UIImageView+WebCache.h>
#import "PositionModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LessonGuideViewController.h"
#import "MYAFNetWork.h"
#import "StudyOnlineCell.h"

@interface StudyOnlineViewController ()
@property(nonatomic,strong) NSMutableArray <PositionModel *> *modelArray;
@end

static NSString *cellId = @"reuseIdentifier";
@implementation StudyOnlineViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   [self.tableView registerNib:[UINib nibWithNibName:@"StudyOnlineCell" bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadPosition)];
   [self.tableView.mj_header beginRefreshing];
}

/**加载岗位*/
-(void)loadPosition
{
    [MYAFNetWork POST:@"http://www.neuedu.cn/m/mobilePostInfo!findPostInfo.action" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.modelArray  = [PositionModel mj_objectArrayWithKeyValuesArray:responseObject[@"indexPositionList"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable resk, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudyOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonGuideViewController *vc = [[LessonGuideViewController alloc] init];
    vc.model = self.modelArray[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
