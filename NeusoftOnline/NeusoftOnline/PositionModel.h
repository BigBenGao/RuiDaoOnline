//
//  PositionModel.h
//  RuiDaoOnline
//
//  Created by gao on 16/9/27.
//  Copyright © 2016年 gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionModel : NSObject
/**岗位Id*/
@property(nonatomic,assign) NSInteger postId;
/**岗位名字*/
@property(nonatomic,copy) NSString * postName;
/**岗位描述*/
@property(nonatomic,copy) NSString * postDesc;
/**岗位图片*/
@property(nonatomic,copy) NSString * postUrl;
/**岗位下课程数量*/
@property(nonatomic,assign) NSInteger courseNums;
/**课程时长*/
@property(nonatomic,assign) NSInteger courseHours;
/**是否正在学习*/
@property(nonatomic,assign) NSInteger isStudy;
/**学习人数*/
@property(nonatomic,assign) NSInteger personNums;
/**学习天数*/
@property(nonatomic,copy) NSString *studyDays;
/**微课程总共包含的测试题数量*/
@property(nonatomic,assign) NSInteger testNums;
/**岗位下课程数量*/
@property(nonatomic,assign) NSInteger videoNums;

@end
