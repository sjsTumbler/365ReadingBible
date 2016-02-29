//
//  PublicFunctions.h
//  ORGUM
//
//  Created by Sun jishuai on 15/9/29.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "DefineUI.h"

typedef NS_ENUM(NSInteger, dataType){
    getData = 0 ,//获取
    setData = 1,//存储
};
@interface PublicFunctions : NSObject
//单例化
+ (PublicFunctions *)sharedPublicFunctions;
//001 HexColor转化为UIColor
- (UIColor *)colorForHex:(NSString *)hexColor;
//002 判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string;
//003 判断是否是手机号码
- (BOOL) isPhoneNumber:(NSString *)phone;
//004 判断是否是电话号码
- (BOOL) isTelNumber:(NSString *)tel;
//005 load Image from caches dir or Documents to imageview
- (NSData*)loadImageDataWithPath:(NSString *) directoryPath andName: (NSString *)imageName;
//006 get file from caches dir or Documents
- (BOOL)getFileWithPath:(NSString *) directoryPath andName: (NSString *)fileName;
//007 判断密码是否有数字和字符组成
- (BOOL) isIncludeNumberAndChar:(NSString *)password;
//008 判断密码是否只有数字组成
- (BOOL) isJuestIncludeNumber:(NSString *)password;
// 009 除去字符串中的符号
- (NSString *)deleteCharactersOfstring:(NSString *)str;
// 010 处理时间戳的显示
- (NSString *)editDate:(double)idate;
// 011压缩算法
- (CGRect)ReduceMethodForBackGroundSize:(CGSize)bgSize rectSize:(CGSize)rectSize;
// 012图片翻转
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
// 013将时间戳转换成时间 -- 已经处理了与服务器的时间戳偏差
/*
 type: 0  --  yyyy-MM-dd HH:mm:ss
 type: 1  --  yyyy-MM-dd HH:mm
 type: 2  --  HH:mm
 */
-(NSString *)dateTimeToString:(double)dateTime Type:(int)type;
//014计算字符串的高度
- (CGSize)getHeightByWidth:(float)width Font:(UIFont *)font Text:(NSString *)text LineBreakMode:(NSLineBreakMode)breakMode;
//015按某一属性排序
- (NSMutableArray *)sortingArray:(NSMutableArray *)recordsArray Property:(NSString *)property Ascending:(BOOL)ascending;
//016判断长网址
- (NSMutableArray *)isURL:(NSString *)text;
//017 按需要生成图片文字按钮
/*
 type :0 默认图左字右
 type :1 图右字左
 type :2 图上字下
 type :3 图下字上
 */
- (UIButton *)imageAndLabelButtonByType:(int)type Label:(NSString *)label LabelTextColor:(UIColor *)iColor NormalImage:(NSString *)normalImage SelectedImage:(NSString *)selectedImage Tag:(int)tag Frame:(CGRect)frame FontSize:(int)fontSize;
//018 NSUserDefaults使用方法
- (void)NSUserDefaults_SaveEditWithValue:(NSString *)value Key:(NSString *)key;
- (void)NSUserDefaults_DeleteWithKey:(NSString *)key;
- (NSString *)NSUserDefaults_ReadWithKey:(NSString *)key;
//19 获取当前时间戳
- (double)getDateTime_Now;


//102 根据不同的附件类型显示图标
- (void)showAnnexWith:(UIImageView *)imgView FileName:(NSString *)fileName FilePath:(NSString *)filePath;
// 获取文件的类型
- (int)getTypeOfFileName:(NSString *)fileName;
@end
