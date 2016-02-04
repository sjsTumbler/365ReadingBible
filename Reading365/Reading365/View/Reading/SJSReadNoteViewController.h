//
//  SJSReadNoteViewController.h
//  Reading365
//
//  Created by SunJishuai on 16/2/3.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "RootViewController.h"
#import "ModelHeader.h"
#import "SJSReadNoteManager.h"

@interface SJSReadNoteViewController : RootViewController
<SJSNavigationDelegate,
UITableViewDelegate,
UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) NSString * viewTitle;
@property(nonatomic,strong) NSDictionary * dataDic;
@property(nonatomic,assign) FSO  dataType;
@end
