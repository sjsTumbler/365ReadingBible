//
//  SJSListViewController.h
//  Reading365
//
//  Created by SunJishuai on 16/1/28.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "RootViewController.h"
#import "HeadView.h"
#import "SJSListManager.h"
#import "SJSReadNoteViewController.h"
#import "SJSListTableViewCell.h"

@interface SJSListViewController : RootViewController
<
SJSNavigationDelegate,
HeadViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
IndexingReadingDelegate
>

@end
