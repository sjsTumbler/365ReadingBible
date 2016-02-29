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
#import "SJSListRootCollectionViewCell.h"
//#import "DefineNSUserDefaults.h"
#import "SJSSegment.h"
#import "SJSListShowViewController.h"

@interface SJSListViewController : RootViewController
<
UIScrollViewDelegate,
SegmentDelegate,
ShowListDelegate
>
@end
