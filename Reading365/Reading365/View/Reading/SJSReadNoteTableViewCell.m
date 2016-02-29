//
//  SJSReadNoteTableViewCell.m
//  Reading365
//
//  Created by SunJishuai on 16/2/4.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSReadNoteTableViewCell.h"
#define DELETE_BUTTON_WIDHT 80
#define EDIT_BUTTON_WIDTH   80
#define BOUNENCE            0 //反弹效果

@implementation SJSReadNoteTableViewCell
{
    CGFloat _startLocation;
    BOOL    _hideMenuView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.iContentView = [[UIView alloc]initWithFrame:self.bounds];
        self.iContentView.backgroundColor = [UIColor whiteColor];
        self.iContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(edages, 0, viewWidth- edages*2, self.bounds.size.height)];
        self.iContentLabel.font = cellFont;
        self.iContentLabel.adjustsFontSizeToFitWidth = YES;
        self.iContentLabel.numberOfLines = 0;
        self.iContentLabel.textColor = [UIColor orangeColor];
        self.iContentLabel.textAlignment = NSTextAlignmentLeft;
        [self.iContentView addSubview:self.iContentLabel];
        [self.contentView addSubview:self.iContentView];
        [self addControl];
    }
    return self;
}
-(void)addControl{
    
    UIView *menuContetnView = [[UIView alloc] init];
    menuContetnView.hidden = YES;
    menuContetnView.tag = 100;
    
    UIButton *vDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vDeleteButton setBackgroundColor:[UIColor colorWithRed:1.0 green:(76.0/256.0) blue:(76.0/256.0) alpha:1.0]];
    [vDeleteButton setTitle:@"笔记" forState:UIControlStateNormal];
//    [vDeleteButton setImage:[UIImage imageNamed:@"delect_cell"] forState:UIControlStateNormal];
    [vDeleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vDeleteButton addTarget:self action:@selector(noteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vDeleteButton setTag:1001];
    
    UIButton *vEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vEditButton setBackgroundColor:[UIColor colorWithRed:(178.0/256.0) green:(178.0/256.0) blue:(178.0/256.0) alpha:1.0]];
     [vEditButton setTitle:@"收藏" forState:UIControlStateNormal];
//    [vEditButton setImage:[UIImage imageNamed:@"edit_cell"] forState:UIControlStateNormal];
    [vEditButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vEditButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vEditButton setTag:1002];
    
    [menuContetnView addSubview:vDeleteButton];
    [menuContetnView addSubview:vEditButton];
    [self.contentView insertSubview:menuContetnView atIndex:0];
    UIPanGestureRecognizer *vPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    vPanGesture.delegate = self;
    [self.contentView addGestureRecognizer:vPanGesture];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    UIView *vMenuView = [self.contentView viewWithTag:100];
    vMenuView.frame =CGRectMake(self.frame.size.width - DELETE_BUTTON_WIDHT - EDIT_BUTTON_WIDTH, 0, DELETE_BUTTON_WIDHT + EDIT_BUTTON_WIDTH, self.frame.size.height);
    
    UIView *vDeleteButton = [self.contentView viewWithTag:1001];
    vDeleteButton.frame = CGRectMake(EDIT_BUTTON_WIDTH, 0, DELETE_BUTTON_WIDHT, self.frame.size.height);
    UIView *vMoreButton = [self.contentView viewWithTag:1002];
    vMoreButton.frame = CGRectMake(0, 0, EDIT_BUTTON_WIDTH, self.frame.size.height);
}
//此方法和下面的方法很重要,对ios 5SDK 设置不被Helighted
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // Configure the view for the selected state
    UIView *vMenuView = [self.contentView viewWithTag:100];
    if (vMenuView.hidden == YES) {
        [super setSelected:selected animated:animated];
        self.backgroundColor = [UIColor whiteColor];
    }
}
//此方法和上面的方法很重要，对ios 5SDK 设置不被Helighted
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    UIView *vMenuView = [self.contentView viewWithTag:100];
    if (vMenuView.hidden == YES) {
        [super setHighlighted:highlighted animated:animated];
    }
}

-(void)prepareForReuse{
    self.contentView.clipsToBounds = YES;
    [self hideMenuView:YES Animated:NO];
}


-(CGFloat)getMaxMenuWidth{
    return DELETE_BUTTON_WIDHT + EDIT_BUTTON_WIDTH;
}

-(void)enableSubviewUserInteraction:(BOOL)aEnable{
    if (aEnable) {
        for (UIView *aSubView in self.contentView.subviews) {
            aSubView.userInteractionEnabled = YES;
        }
    }else{
        for (UIView *aSubView in self.contentView.subviews) {
            UIView *vDeleteButtonView = [self.contentView viewWithTag:100];
            if (aSubView != vDeleteButtonView) {
                aSubView.userInteractionEnabled = NO;
            }
        }
    }
}

-(void)hideMenuView:(BOOL)aHide Animated:(BOOL)aAnimate{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGRect vDestinaRect = CGRectZero;
    if (aHide) {
        vDestinaRect = self.contentView.frame;
        [self enableSubviewUserInteraction:YES];
    }else{
        vDestinaRect = CGRectMake(-[self getMaxMenuWidth], self.contentView.frame.origin.x, self.contentView.frame.size.width, self.contentView.frame.size.height);
        [self enableSubviewUserInteraction:NO];
    }
    
    CGFloat vDuration = aAnimate? 0.4 : 0.0;
    [UIView animateWithDuration:vDuration animations:^{
        self.iContentView.frame = vDestinaRect;
    } completion:^(BOOL finished) {
        if (aHide) {
            if ([_delegate respondsToSelector:@selector(didCellHided:)]) {
                [_delegate didCellHided:self];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(didCellShowed:)]) {
                [_delegate didCellShowed:self];
            }
        }
        UIView *vMenuView = [self.contentView viewWithTag:100];
        vMenuView.hidden = aHide;
    }];
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint vTranslationPoint = [gestureRecognizer translationInView:self.contentView];
        return fabs(vTranslationPoint.x) > fabs(vTranslationPoint.y);
    }
    return YES;
}

-(void)handlePan:(UIPanGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _startLocation = [sender locationInView:self.contentView].x;
        CGFloat direction = [sender velocityInView:self.contentView].x;
        if (direction < 0) {
            if ([_delegate respondsToSelector:@selector(didCellWillShow:)]) {
                [_delegate didCellWillShow:self];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(didCellWillHide:)]) {
                [_delegate didCellWillHide:self];
            }
        }
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGFloat vCurrentLocation = [sender locationInView:self.contentView].x;
        CGFloat vDistance = vCurrentLocation - _startLocation;
        _startLocation = vCurrentLocation;
        
        CGRect vCurrentRect = self.iContentView.frame;
        CGFloat vOriginX = MAX(-[self getMaxMenuWidth] - BOUNENCE, vCurrentRect.origin.x + vDistance);
        vOriginX = MIN(0 + BOUNENCE, vOriginX);
        self.iContentView.frame = CGRectMake(vOriginX, vCurrentRect.origin.y, vCurrentRect.size.width, vCurrentRect.size.height);
        CGFloat direction = [sender velocityInView:self.contentView].x;
//        NSLog(@"direction:%f",direction);
//        NSLog(@"vOriginX:%f",vOriginX);
        if (direction < -40.0 || vOriginX <  - (0.5 * [self getMaxMenuWidth])) {
            _hideMenuView = NO;
            UIView *vMenuView = [self.contentView viewWithTag:100];
            vMenuView.hidden = _hideMenuView;
        }else if(direction > 20.0 || vOriginX >  - (0.5 * [self getMaxMenuWidth])){
            _hideMenuView = YES;
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [self hideMenuView:_hideMenuView Animated:YES];
    }
}


#pragma mark  点击收藏
-(void)saveButtonClicked:(id)sender{
    if ([_delegate respondsToSelector:@selector(didCellClickedSaveButton:)]) {
        [_delegate didCellClickedSaveButton:self];
    }
}

#pragma mark 点击笔记
-(void)noteButtonClicked:(id)sender{
    [self.superview sendSubviewToBack:self];
    if ([_delegate respondsToSelector:@selector(didCellClickedNoteButton:)]) {
        [_delegate didCellClickedNoteButton:self];
    }
}
#pragma mark 动态改变frame
-(void)frameToFitSize:(CGFloat)height {
    CGRect viewRect = self.iContentView.frame;
    CGRect labelRect = self.iContentLabel.frame;
    viewRect.size.height = height;
    labelRect.size.height = height;
    self.iContentView.frame = viewRect;
    self.iContentLabel.frame = labelRect;
}
//选中cell
- (void)changeSelectedColor:(BOOL)select {
    if (select) {
        //测试颜色
        self.iContentView.backgroundColor = [UIColor yellowColor];
    }else {
        self.iContentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
