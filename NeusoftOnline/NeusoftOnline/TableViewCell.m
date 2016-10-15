//
//  TableViewCell.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/30.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "TableViewCell.h"
#import <UIImageView+WebCache.h>
@interface TableViewCell()
/**学习时长*/
@property (weak, nonatomic) IBOutlet UILabel *learnTime;
/**课程数量*/
@property (weak, nonatomic) IBOutlet UILabel *courseNum;
/**是否学过*/
@property (weak, nonatomic) IBOutlet UILabel *alreadyLearn;
/**学习人数*/
@property (weak, nonatomic) IBOutlet UILabel *learnNums;
/**课程图片*/
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;

@end

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

}

-(void)setModel:(PositionModel *)model
{
    self.learnTime.text = [NSString stringWithFormat:@"学习时长: %ld",model.courseHours];
    self.courseNum.text = [NSString stringWithFormat:@"课程数量: %ld",model.videoNums];
    if(self.model.isStudy == 1)
    {
        self.alreadyLearn.text = [NSString stringWithFormat:@"是否学过: 是"];
    }

    self.learnNums.text = [NSString stringWithFormat:@"学习人数: %ld",model.personNums];
    
    [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:model.postUrl] placeholderImage:[UIImage imageNamed:@"1111.jpg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
