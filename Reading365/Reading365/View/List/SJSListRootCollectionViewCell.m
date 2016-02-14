//
//  SJSListRootCollectionViewCell.m
//  Reading365
//
//  Created by SunJishuai on 16/2/14.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSListRootCollectionViewCell.h"

@implementation SJSListRootCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _abbreLabel = [[UILabel alloc] init];
        _abbreLabel.frame = CGRectMake(0, 0, rootListWH,rootListWH);
        _abbreLabel.backgroundColor = iColorWithHex(0xeeeeee);
        //给图层添加一个有色边框
        _abbreLabel.layer.borderWidth = 0.5;
        _abbreLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
        _abbreLabel.userInteractionEnabled = YES;
        _abbreLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_abbreLabel];
        
    }
    return self;
}
@end
