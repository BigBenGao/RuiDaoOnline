//
//  LessonListViewController.m
//  RuiDaoOnline
//
//  Created by gao on 16/10/8.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "LessonListViewController.h"
#import "MYAFNetWork.h"
#import "LessonDetailModel.h"
#import "LessonList.h"
#import <MJExtension.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LessonListViewController ()
@property(nonatomic,strong) NSMutableArray<LessonList *> *modelArray;
@property(nonatomic,strong) AVPlayerViewController *playerController;
@property(nonatomic,strong) AVPlayerItem *item;
@end

@implementation LessonListViewController

-(AVPlayerViewController *)playerController
{
    if(_playerController == nil)
    {
        _playerController = [[AVPlayerViewController alloc] init];
        
        self.playerController.player = [[AVPlayer alloc] initWithPlayerItem:self.item];
    }
    return _playerController;
}

-(AVPlayerItem *)item
{
    if(_item == nil)
    {
        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        
        _item = [[AVPlayerItem alloc] initWithAsset:asset];
        
        NSLog(@"新的item");
        
        [_item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [_item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [_item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [_item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
         
    }
    return _item;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"移除播放项目");

    if(_item)
    {

        [_item removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_item removeObserver:self forKeyPath:@"status"];
        [_item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        
        self.item = nil;
    }
    else
    {
         NSLog(@"item == nil");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    [self loadLessonList];

}

-(void)loadLessonList
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"courseid"] = @(self.model.resId);
    [MYAFNetWork GET:@"http://www.neuedu.cn/m/mobileCourseInfo!findMoreMcourses.action" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        self.modelArray = [LessonList mj_objectArrayWithKeyValuesArray:responseObject[@"courseList"]];
        [self.tableView reloadData];
        
     } failure:^(NSURLSessionDataTask * _Nullable resk, NSError * _Nonnull error) {
         NSLog(@"%@",error.localizedDescription);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];   
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        if ([self.item status] == AVPlayerStatusReadyToPlay)
        {
            //表示多少秒
            CGFloat duration = self.item.duration.value / self.item.duration.timescale; //视频总时间
            
            NSLog(@"准备好播放了，总时间：%.2f", duration);//还可以获得播放的进度，这里可以给播放进度条赋值了
            
        }
        else if([self.item status] == AVPlayerStatusFailed || AVPlayerStatusUnknown)
        {
            NSLog(@"播放失败或者异常");
            [self.playerController.player pause];
        }
    }
    else if([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSArray *loadedTimeRanges = [self.item loadedTimeRanges];
        
        NSLog(@"收到%ld个数据",loadedTimeRanges.count);
        
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        
        float startSeconds    = CMTimeGetSeconds(timeRange.start);
        NSLog(@"开始时间%f",startSeconds);
        
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSLog(@"持续时间%f 结束时间:%f",durationSeconds,startSeconds + durationSeconds);
        
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        
        CMTime duration = self.item.duration;
        
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        NSLog(@"下载进度：%.2f", timeInterval / totalDuration);
        
    }
    else if([keyPath isEqualToString:@"playbackBufferEmpty"])
    {
        NSLog(@"缓存不足暂停了");
    }
    else if([keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        NSNumber  *b = [[NSNumber alloc]initWithBool:change[NSKeyValueChangeNewKey]];
        if(b.boolValue == YES)
        {
            [self.playerController.player play];
            NSLog(@"好像能播放了");
        }
        else
        {
            NSLog(@"暂时不能播放");
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.modelArray[section].mList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.modelArray[indexPath.section].mList[indexPath.row].title;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.modelArray[section].title;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonDetailModel *dModel = self.modelArray[indexPath.section].mList[indexPath.row];
    
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:dModel.url]];
    
    [self.item setValue:asset forKey:@"asset"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.playerController.player replaceCurrentItemWithPlayerItem:self.item];
    });
    
    [self.playerController.player seekToTime:kCMTimeZero];
    
    [self presentViewController:self.playerController animated:YES completion:^{
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }];
}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.item removeObserver:self forKeyPath:@"status"];
    [self.item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}


@end
