//
//  OnlineTestViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/10/11.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "OnlineTestViewController.h"
#import "LogoutTableViewController.h"
@interface OnlineTestViewController ()

@property(nonatomic,strong) NSMutableArray<NSArray<NSString *>*> *array;
@property(nonatomic,strong) NSMutableArray <NSNumber *>*scoreArray;
@property(nonatomic,assign) NSInteger QuesSection;

@end

@implementation OnlineTestViewController


-(NSMutableArray *)scoreArray
{
    if (_scoreArray == nil)
    {
        _scoreArray = [NSMutableArray arrayWithCapacity:10];
        for(int i = 0 ; i < self.array.count ; i++)
        {
           _scoreArray[i] = @(-1);
        }
    }
    return _scoreArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    NSString *path = [[ NSBundle mainBundle] pathForResource:@"tiku" ofType:@"plist"];
    self.array = [NSMutableArray arrayWithContentsOfFile:path];
    self.QuesSection = 0;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一题" style:UIBarButtonItemStyleDone target:self action:@selector(previous)];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一题" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)previous
{
    if(--self.QuesSection == 0)
    {
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
    [self.tableView reloadData];
    
    if (self.scoreArray[self.QuesSection].integerValue != -1)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.scoreArray[self.QuesSection].integerValue-1 inSection:0];
         [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
   
}

-(void)next
{
    if(self.QuesSection == self.array.count - 1)
    {
        NSInteger scor = 0;
        //NSLog(@"全部完成");
        
        for(int i = 0 ; i < self.array.count ; i++)
        {
         //   NSLog(@"第%d题 选了＝ %ld",i + 1,self.scoreArray[i].integerValue);
         //   NSLog(@"正确答案是 ＝ %@",self.array[i][5]);
            if(self.scoreArray[i].integerValue == self.array[i][5].integerValue)
            {
                scor += 10;
         //     NSLog(@"第%d题答案正确",i + 1);
            }
        }
        
        UINavigationController *v = self.tabBarController.childViewControllers[2];
        LogoutTableViewController *vc = (LogoutTableViewController *)v.topViewController;
        vc.score = scor;
        self.tabBarController.selectedIndex = 2;
        
    }
    else if(++self.QuesSection == self.array.count - 1)
    {
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self.tableView reloadData];
    }
    else
    {
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [self.tableView reloadData];
    }
    
    if (self.scoreArray[self.QuesSection].integerValue != -1)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.scoreArray[self.QuesSection].integerValue-1 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array[self.QuesSection].count - 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.array[self.QuesSection][0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
   
    cell.textLabel.text = self.array[self.QuesSection][indexPath.row + 1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld行  答案保存 ＝ %ld",indexPath.row + 1,indexPath.row + 1);
    self.scoreArray[self.QuesSection] = @(indexPath.row + 1);
    
    [self next];
}


@end
