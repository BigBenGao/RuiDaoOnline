//
//  examModel.h
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface examModel : NSObject
@property(nonatomic,copy) NSString *examType;
@property(nonatomic,copy) NSString *resName;
@property(nonatomic,copy) NSString *resProcess;
@property(nonatomic,assign) NSInteger resType;
@property(nonatomic,assign) NSInteger resId;
@end
