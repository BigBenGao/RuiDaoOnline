//
//  StudyOnlineCell.m
//  RuiDaoOnline
//
//  Created by gao on 16/9/30.
//  Copyright © 2016年 gao. All rights reserved.
//

#import "StudyOnlineCell.h"
#import <UIImageView+WebCache.h>
@interface StudyOnlineCell()
@property (weak, nonatomic) IBOutlet UILabel *postNamelabel;
@property (weak, nonatomic) IBOutlet UIImageView *positionImage;
@end
@implementation StudyOnlineCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setModel:(PositionModel *)model
{
    [self.positionImage sd_setImageWithURL:[NSURL URLWithString:model.postUrl] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    self.postNamelabel.text = model.postName;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
