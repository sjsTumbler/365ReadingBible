//
//  HeadView.h
//

//

#import <UIKit/UIKit.h>
#import "DefineUI.h"
@protocol HeadViewDelegate; 

@interface HeadView : UIView

@property(nonatomic, assign) id<HeadViewDelegate> delegate;
@property(nonatomic, assign) NSInteger section;
@property(nonatomic, assign) BOOL open;
@property(nonatomic, retain) UIButton* backBtn;
@end

@protocol HeadViewDelegate <NSObject>
-(void)selectedWith:(HeadView *)view;
@end
