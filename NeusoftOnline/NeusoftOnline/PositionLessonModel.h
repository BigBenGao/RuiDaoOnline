//
//  PositionLessonModel.h
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionLessonModel : NSObject
/**课程名*/
@property(nonatomic,copy)   NSString *parentStageName;

@property(nonatomic,assign) NSInteger stageId;

@property(nonatomic,copy)   NSString *stageName;

@property(nonatomic,assign) NSInteger stageProcess;

@property(nonatomic,strong) NSMutableArray  *childStageResList;

+(NSDictionary *)mj_objectClassInArray;

@end
