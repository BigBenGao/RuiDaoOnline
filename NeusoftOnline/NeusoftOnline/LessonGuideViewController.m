//
//  LessonGuideViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/30.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "LessonGuideViewController.h"

#import "TableViewCell.h"
#import "PositionLessonViewController.h"

@interface LessonGuideViewController ()

@end

static NSString *cellId = @"reuseIdentifier";

@implementation LessonGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    label.numberOfLines = 0;
    label.text = [self.model.postDesc stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    [label sizeToFit];
    
    
    self.tableView.tableFooterView = label;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, label.frame.size.height + label.frame.origin.y + 40, self.view.frame.size.width - 40, 40)];
    [button setTitle:@"课程详细" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(courseDetail) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    
    [self.tableView addSubview:button];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)courseDetail
{
    PositionLessonViewController *vc = [[PositionLessonViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
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
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"课程介绍";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


@end
