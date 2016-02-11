//
//  SJSListTableViewCell.h
//  Reading365
//
//  Created by SunJishuai on 16/2/11.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineUI.h"
#import "SJSListCollectionViewCell.h"
#import "IndexingModel.h"

@protocol IndexingReadingDelegate <NSObject>

- (void)didSelectedCollectionIndex:(NSIndexPath*)indexPath;

@end

@interface SJSListTableViewCell : UITableViewCell
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong) id<IndexingReadingDelegate> delegate;
- (void)setCellByModel:(IndexingModel *)model;
@end
