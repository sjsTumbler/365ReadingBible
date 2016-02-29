//
//  SJSStatistricsViewController.h
//  Reading365
//
//  Created by SunJishuai on 16/1/28.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JBCalendarLogic.h"
#import "JBUnitView.h"
#import "JBUnitGridView.h"
#import "JBSXRCUnitTileView.h"
@interface SJSStatistricsViewController : RootViewController
<
JBUnitGridViewDelegate,
JBUnitGridViewDataSource,
JBUnitViewDelegate,
JBUnitViewDataSource>

@property (nonatomic, retain) JBUnitView *unitView;
@property (nonatomic, retain) UITableView *tableView;


- (void)selectorForButton;
@end
