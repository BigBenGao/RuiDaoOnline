//
//  TableViewCell.h
//  RuiDaoOnline
//
//  Created by gao on 16/9/30.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionModel.h"

@interface TableViewCell : UITableViewCell
@property(nonatomic,strong) PositionModel *model;
@end
