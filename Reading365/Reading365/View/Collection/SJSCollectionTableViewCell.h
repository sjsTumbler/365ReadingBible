//
//  SJSCollectionTableViewCell.h
//  Reading365
//
//  Created by SunJishuai on 16/2/26.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJSCollectionTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *chapterSectionLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *contentLabel;


-(void)frameToFitSize:(CGFloat)height;
@end
