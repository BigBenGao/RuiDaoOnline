//
//  LessonList.h
//  RuiDaoOnline
//
//  Created by gao on 16/10/8.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LessonDetailModel;
@interface LessonList : NSObject
@property(nonatomic,strong) NSMutableArray <LessonDetailModel *> *mList;
@property(nonatomic,assign) NSInteger time;
@property(nonatomic,copy)   NSString* title;

+(NSDictionary *)mj_objectClassInArray;

@end
