//
//  SJSListShowViewController.h
//  Reading365
//
//  Created by SunJishuai on 16/2/20.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  封装的目录显示视图
/*
 collectionview的子视图，具有列表和矩阵切换的功能，负责新约或旧约的列表、矩阵显示
 */

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "IndexingModel.h"
#import "SJSListManager.h"
#import "SNavigationBar.h"
#import "SJSListRootCollectionViewCell.h"
#import "SJSListTableViewCell.h"

@protocol ShowListDelegate <NSObject>
@optional
- (void)didSelectedShowListCollectionWithTitle:(NSString *)title DataType:(FSO)type SectionName:(NSString *)sectionName chapterNumber:(NSString *)chapterNumber;
@end

@interface SJSListShowViewController : UIViewController
<
HeadViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
IndexingReadingDelegate
>

@property(nonatomic, weak) id <ShowListDelegate> delegate;
@property (nonatomic,assign) int old_new;//old-0,new-1
@property (nonatomic,assign) int table_collection;//table-0,collection-1

//初始化
- (id)initWithFrame:(CGRect)frame Old_new:(int)old_new Table_collection:(int)table_collection;
//切换table和collection
- (void)setTableOrCollection:(int)table_collection;
@end
