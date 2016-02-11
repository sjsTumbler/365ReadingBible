//
//  SJSListCollectionViewCell.m
//  Reading365
//
//  Created by SunJishuai on 16/2/12.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSListCollectionViewCell.h"

@implementation SJSListCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.frame = CGRectMake(0, 0, 50, 50);
        _numberLabel.backgroundColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numberLabel];
        
    }
    return self;
}
@end
