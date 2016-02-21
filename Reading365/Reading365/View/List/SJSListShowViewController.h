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

@interface SJSListShowViewController : UIViewController
<
HeadViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
SJSNavigationDelegate,
IndexingReadingDelegate
>

@property (nonatomic,assign) int old_new;//old-0,new-1
@property (nonatomic,assign) int table_collection;//table-0,collection-1


@end
