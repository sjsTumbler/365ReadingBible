//
//  SJSReadNoteTableViewCell.h
//  Reading365
//
//  Created by SunJishuai on 16/2/4.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DefineUI.h"

@protocol ReadNoteTableViewCellDelegate <NSObject>

-(void)didCellWillHide:(id)aSender;
-(void)didCellHided:(id)aSender;
-(void)didCellWillShow:(id)aSender;
-(void)didCellShowed:(id)aSender;
-(void)didCellClickedSaveButton:(id)aSender;
-(void)didCellClickedNoteButton:(id)aSender;
@end

@interface SJSReadNoteTableViewCell : UITableViewCell
<UIGestureRecognizerDelegate>

@property (nonatomic,assign) id<ReadNoteTableViewCellDelegate> delegate;
@property (nonatomic,strong) UIView * iContentView;
@property (nonatomic,strong) UILabel * iContentLabel;

//选中
@property (nonatomic,assign) BOOL iSelected;


-(void)hideMenuView:(BOOL)aHide Animated:(BOOL)aAnimate;
-(void)addControl;
-(void)frameToFitSize:(CGFloat)height;

//选中cell
- (void)changeSelectedColor:(BOOL)select;
@end
