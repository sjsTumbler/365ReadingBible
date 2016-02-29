//
//  SHTabbar.m
//  Reading365
//
//  Created by ccSunday on 16/2/27.
//  Copyright © 2016年 SunJishuai. All rights reserved.
//

#import "SHTabbar.h"

#import "SHTabBarController.h"

@interface SHTabbar()
{
    UIButton *middleBtn;
}
@end


@implementation SHTabbar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

    }
    
    return self;
}


/**
 *  自定义tabbar
 */


-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    CGFloat buttonW = barWidth / self.dataArray.count ;
    CGFloat buttonH = barHeight - 1;
    CGFloat buttonY = 1;
    NSInteger buttonIndex = 0;
    
    for (NSDictionary *unitDict in self.dataArray) {
        NSString *title = unitDict[@"title"];
        
        NSString *image = unitDict[@"image"];
        
        NSString *image_sel = unitDict[@"image_sel"];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:image]forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:image_sel] forState:UIControlStateHighlighted];
        
        [btn setImage:[UIImage imageNamed:image_sel] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        btn.tag = buttonIndex;
        
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
        
        CGFloat buttonX = buttonIndex * buttonW;
        
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleEdgeInsets = UIEdgeInsetsMake(28, -66, -5, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(-12, 5, 0, 0);
        //        btn.titleLabel.center = CGPointMake(btn.imageView.center.x, btn.imageView.frame.origin.x+btn.imageView.frame.size.height);
        buttonIndex ++;
        
        [self addSubview:btn];
        if (buttonIndex == 0) {
            btn.selected = YES;
            middleBtn = btn;
        }
        
    }

}

/**
 *  按钮点击
 *
 *  @param btn
 */
- (void)btnclick:(UIButton *)btn{
    if (middleBtn == btn) {
        return;
    }
    else{
        btn.selected = !btn.selected;
        middleBtn.selected = NO;
        middleBtn = btn;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"controllerChanged" object:btn];
    
}


/**
 *  tabbar赋值
 *
 *  @param array
 */

- (void)setDataArray:(NSArray *)dataArray{
        _dataArray = dataArray;
}

/**
 *
 *
 *  @param showIconIndex 需要显示消息标志的按钮  
                         可以添加显示消息数目
 */
- (void)setShowIconIndex:(NSInteger)showIconIndex{
    
//    NSLog(@"%ld",showIconIndex);
    
    for (UIButton *btn  in self.subviews) {
        if (btn.tag == showIconIndex) {
            UIView *view = [[UIView alloc]init];
            view.frame = CGRectMake(10, 10, 10, 10);
            view.backgroundColor = [UIColor redColor];
            [btn addSubview:view];
        }
    }
    
    
}

@end
