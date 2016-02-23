//
//  SJSSegment.m
//  Reading365
//
//  Created by SunJishuai on 16/2/17.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSSegment.h"

@implementation SJSSegment

- (id)initSegmentWithFrame:(CGRect)frame TitleList:(NSArray *)titleList {
    if (self = [super initWithFrame:frame]) {
        self.titleList = [[NSMutableArray alloc]initWithArray:titleList];
        [self createItem:self.titleList];
    }
    return self;
}
- (NSMutableArray *)titleList
{
    if (!_titleList)
    {
        _titleList = [NSMutableArray array];
    }
    return _titleList;
}
- (void)createItem:(NSMutableArray *)item {
    
    int count = (int)self.titleList.count;
    CGFloat marginX = (viewWidth - count * segmentButtonwidth)/(count + 1);
    for (int i = 0; i<count; i++) {
        
        NSString *temp = [self.titleList objectAtIndex:i];
        //按钮的X坐标计算，i为列数
        CGFloat buttonX = marginX + i * (segmentButtonwidth + marginX);
        UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, segmentButtonwidth, segmentHeight)];
        //设置
        buttonItem.tag = i+100;
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        [buttonItem setTitleColor:iColorWithHex(segmentNormalColor) forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];
        //第一个按钮默认被选中
        if (i == _indexDefaults) {
            CGFloat firstX = buttonX;
            [buttonItem setTitleColor:iColorWithHex(segmentSelectColor) forState:UIControlStateNormal];
            [self creatBanner:firstX];
        }
        buttonX += marginX;
    }
}

-(void)creatBanner:(CGFloat)firstX{
    //初始化
    CALayer *LGLayer = [[CALayer alloc]init];
    LGLayer.backgroundColor = iColorWithHex(segmentSelectColor ).CGColor;
    LGLayer.frame = CGRectMake(firstX, segmentHeight - 6, segmentButtonwidth, 5);
    // 设定它的frame
    LGLayer.cornerRadius = 4;// 圆角处理
    [self.layer addSublayer:LGLayer]; // 增加到UIView的layer上面
    self.LGLayer = LGLayer;
}

-(void)buttonClick:(UIButton *)clickButton {
    [clickButton setTitleColor:iColorWithHex(segmentSelectColor) forState:UIControlStateNormal];
    CGFloat bannerX = clickButton.center.x;
    [self bannerMoveTo:bannerX];
    [self didSelectButton:clickButton];
    [self.delegate scrollToPage:(int)clickButton.tag-100];
}

-(void)bannerMoveTo:(CGFloat)bannerX{
    //基本动画，移动到点击的按钮下面
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(bannerX, 100)];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 0.3;
    //设置代理
    animationGroup.delegate = self;
    //1.3设置动画执行完毕后不删除动画
    animationGroup.removedOnCompletion=NO;
    //1.4设置保存动画的最新状态
    animationGroup.fillMode=kCAFillModeForwards;
    
    //监听动画
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    //动画加入到changedLayer上
    [_LGLayer addAnimation:animationGroup forKey:nil];
}
//点击按钮后改变字体颜色
-(void)didSelectButton:(UIButton*)Button {
    //保存操作动作
    [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:[NSString stringWithFormat:@"%ld",Button.tag-100] Key:Old_New_Bible];
    
    for (int i = 0; i< self.titleList.count; i++) {
        if (i == Button.tag-100) {
            [Button setTitleColor:iColorWithHex(segmentSelectColor) forState:UIControlStateNormal];
        }else{
            [((UIButton *)[self viewWithTag:i+100]) setTitleColor:iColorWithHex(segmentNormalColor) forState:UIControlStateNormal];
        }
    }
}
-(void)moveToOffsetX:(CGFloat)offsetX {
    CGFloat bannerX = ((UIButton *)[self viewWithTag:100]).center.x;
    CGFloat offSet = offsetX;
    CGFloat addX = offSet/viewWidth *(((UIButton *)[self viewWithTag:101]).center.x - ((UIButton *)[self viewWithTag:100]).center.x);
    bannerX += addX;
    [self bannerMoveTo:bannerX];
    int i = offsetX/viewWidth;
    int j = (int)offsetX%(int)viewWidth;
    if (j==0) {
        [self didSelectButton:(UIButton *)[self viewWithTag:100+i]];
    }
    
}

@end
