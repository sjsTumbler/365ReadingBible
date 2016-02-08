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
#import "SJSReadNotePopView.h"
#import "SJSReadNoteTableViewCell.h"

@interface SJSReadNoteViewController : RootViewController
<SJSNavigationDelegate,
UITableViewDelegate,
UITableViewDataSource,
ReadNoteTableViewCellDelegate>
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) NSString * viewTitle;
@property(nonatomic,strong) NSDictionary * dataDic;
@property(nonatomic,assign) FSO  dataType;
@property(nonatomic,assign) BOOL canCustomEdit;
@end
