//
//  LessonListViewController.h
//  RuiDaoOnline
//
//  Created by gao on 16/10/8.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "examModel.h"
@interface LessonListViewController : UITableViewController
@property(nonatomic,strong) examModel *model;
@end
