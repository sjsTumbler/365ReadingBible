//
//  HeadView.m


#import "HeadView.h"

@implementation HeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _open = NO;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, viewWidth , moreListSectionHeight-0.5);
        [btn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, moreListSectionHeight-0.5, viewWidth, 0.5)];
        line.backgroundColor = iColorWithHex(0xeeeeee);
        [self addSubview:line];
        [self addSubview:btn];
        self.backBtn = btn;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)doSelected{
    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:)]){
     	[_delegate selectedWith:self];
    }
}
@end
