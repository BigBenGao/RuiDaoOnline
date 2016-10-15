//
//  PositionLessonViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "PositionLessonViewController.h"
#import "MYAFNetWork.h"
#import "PositionModel.h"
#import "examModel.h"
#import "PositionLessonModel.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "LessonListViewController.h"

@interface PositionLessonViewController ()
@property(nonatomic,strong) NSMutableArray <PositionLessonModel *> *modelArray;
@end

@implementation PositionLessonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadLesson)];
    [self.tableView.mj_header beginRefreshing];

    self.title = self.model.postName;
}

-(void)loadLesson
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"postid"] = @(self.model.postId);
   

    [MYAFNetWork POST:@"http://www.neuedu.cn/m/mobilePostCourse!findPostCourse.action" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        self.modelArray = [PositionLessonModel mj_objectArrayWithKeyValuesArray:responseObject[@"postStageResList"]];
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
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray[section].childStageResList.count;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    PositionLessonModel *model = self.modelArray[section];
    NSString *name = [NSString stringWithFormat:@"%@-%@",model.parentStageName,model.stageName];
    return name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    examModel *model = self.modelArray[indexPath.section].childStageResList[indexPath.row];
    cell.textLabel.text = model.resName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonListViewController *LLVC = [[LessonListViewController alloc] init];
    LLVC.model = self.modelArray[indexPath.section].childStageResList[indexPath.row];
    LLVC.title = LLVC.model.resName;
    [self.navigationController pushViewController:LLVC animated:YES];
}


@end
