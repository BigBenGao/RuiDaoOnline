//
//  PositionLessonModel.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "PositionLessonModel.h"

@implementation PositionLessonModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
                @"childStageResList":@"examModel"
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
                @"stageId":@"childStageList[0].stageId",
                @"stageName":@"childStageList[0].stageName",
                @"stageProcess":@"childStageList[0].stageProcess",
                @"childStageResList":@"childStageList[0].childStageResList"
            };
}
@end
