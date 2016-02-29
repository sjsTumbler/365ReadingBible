//
//  searchSelectedView.m
//  Reading365
//
//  Created by ccSunday on 16/2/25.
//  Copyright © 2016年 SunJishuai. All rights reserved.
//

#import "searchSelectedView.h"
#define BTN_SPACE 10
#define BTN_BASE_TAG  1234
@interface searchSelectedView()
{
    UIScrollView *segScrollView;
    UILabel *titleLabel;
    UIView *lineView;
    UIButton *currentBtn;
    CGFloat offsetx;
    
}

@property (nonatomic, strong)NSArray *segmentArr;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)CGRect viewframe;
@property (nonatomic, strong)NSMutableArray *lengthArr;
@end


@implementation searchSelectedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame Title:(NSString *)title segArray:(NSArray *)segArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.segmentArr = segArr;
        self.viewframe = frame;
        self.title = title;
        self.layer.borderWidth = 0.5;
        [self setUpSubviews];
    }
    return self;
}


- (void)setUpSubviews{
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.height)];
    titleLabel.layer.borderWidth = 0.5;
    titleLabel.layer.borderColor = GetColor(grayColor).CGColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    titleLabel.font = GetFont(14);
    [self addSubview:titleLabel];
//    self.width
    segScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(titleLabel.right, 0, self.width-40-60, self.height )];
    CGFloat contentLength;
    //创建btn
    for (NSInteger i = 0; i<self.segmentArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.segmentArr[i] forState:UIControlStateNormal];
//        btn.backgroundColor = GetColor(redColor);
        btn.tag = BTN_BASE_TAG + i;
        btn.titleLabel.font = GetFont(14);
        [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:GetColor(blackColor) forState:UIControlStateNormal];
        [btn setTitleColor:GetColor(redColor) forState:UIControlStateSelected];
        NSString *nameStr;
        nameStr = self.segmentArr[i];
        CGSize unitSize = [NSString getSizeWithString:nameStr andHeight:self.height andFont:GetFont(14)];
        btn.frame = CGRectMake(BTN_SPACE*(i+1)+contentLength, 0, unitSize.width, self.height);
        contentLength += unitSize.width;
        
        [self.lengthArr addObject:@(btn.left+btn.width+BTN_SPACE)];
        
        [segScrollView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            currentBtn = btn;
            lineView = [[UIView alloc]initWithFrame:CGRectMake(btn.left, self.height-4, btn.width, 2)];
            lineView.backgroundColor = GetColor(redColor);
            [segScrollView addSubview:lineView];
            
        }
    }
    segScrollView.contentSize = CGSizeMake(contentLength+BTN_SPACE*(self.segmentArr.count+1), self.height);
    segScrollView.pagingEnabled = NO;
    segScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:segScrollView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(segScrollView.right, 0, 40, self.height);
    [nextBtn setImage:GetImage(@"btn_right_arrow") forState:UIControlStateNormal];
    nextBtn.titleLabel.font = GetFont(14);
    nextBtn.layer.borderWidth = 0.5;
    nextBtn.layer.borderColor = GetColor(grayColor).CGColor;
    [self addSubview:nextBtn];
}



- (NSArray *)segmentArr{
    if (!_segmentArr) {
        _segmentArr = [NSArray array];
    }
    return _segmentArr;
}

- (NSMutableArray *)lengthArr{
    if (!_lengthArr) {
        _lengthArr = [NSMutableArray array];
    }
    return _lengthArr;
   
}

- (void)btnSelected:(UIButton *)btn{
    if (currentBtn == btn) {
        return;
    }
    btn.selected = !btn.selected;
    currentBtn.selected = NO;
    currentBtn = btn;
     CGPoint point;
    point = CGPointMake(offsetx, 0);
    if ([self.lengthArr[(btn.tag-BTN_BASE_TAG)] intValue]>=segScrollView.width) {
        if ([[self.lengthArr lastObject] integerValue] - btn.left<segScrollView.width   ) {
            point = CGPointMake(offsetx, 0);
        }
        else{
            if (btn.tag-BTN_BASE_TAG==self.segmentArr.count-1) {
                point = CGPointMake(offsetx, 0);
            }
            else{
              offsetx = [self.lengthArr[btn.tag+1 - BTN_BASE_TAG] integerValue] - segScrollView.width;
             NSLog(@"offsetx=%f",offsetx);
             point = CGPointMake(offsetx, 0);
            }
        }
    }
    
    

    
    NSLog(@"pointx:%f",point.x);
    NSLog(@"lengarr=%@",self.lengthArr[btn.tag-BTN_BASE_TAG]);
//    CGPoint point = CGPointMake([self.lengthArr[(btn.tag-BTN_BASE_TAG)] intValue] , 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        
//        segScrollView.contentOffset = point;
        
        lineView.frame = CGRectMake(btn.left, lineView.top, btn.width, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


@end
