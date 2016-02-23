//
//  SJSSegment.h
//  Reading365
//
//  Created by SunJishuai on 16/2/17.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineUI.h"
#import "PublicFunctions.h"
#import "DefineNSUserDefaults.h"

@protocol SegmentDelegate <NSObject>
@optional
- (void)scrollToPage:(int)page;
@end
@interface SJSSegment : UIView

@property(nonatomic, weak) id <SegmentDelegate> delegate;
@property(nonatomic,strong) NSMutableArray *titleList;//标题列表
@property(nonatomic,assign) int indexDefaults;
@property(nonatomic,weak)   CALayer *LGLayer;


-(id)initSegmentWithFrame:(CGRect)frame TitleList:(NSArray *)titleList IndexDefaults:(int)indexDefaults;
-(void)moveToOffsetX:(CGFloat)X;

@end
