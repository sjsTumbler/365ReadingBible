//
//  SJSCollectionTableViewCell.m
//  Reading365
//
//  Created by SunJishuai on 16/2/26.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSCollectionTableViewCell.h"

@implementation SJSCollectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _chapterSectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(edages, 0, 100,labelHeight)];
        _chapterSectionLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_chapterSectionLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth-edages-100, 0, 100, labelHeight)];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(edages, labelHeight, viewWidth-edages*2, self.bounds.size.height)];
        _contentLabel.textColor = [UIColor orangeColor];
        _contentLabel.numberOfLines = 0;
//        _contentLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:_contentLabel];
    }
    return self;
}
#pragma mark 动态改变frame
-(void)frameToFitSize:(CGFloat)height {
    CGRect labelRect = self.contentLabel.frame;
    labelRect.size.height = height;
    self.contentLabel.frame = labelRect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
