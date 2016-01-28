//
//  PublicFunctions.m
//  ORGUM
//
//  Created by Sun jishuai on 15/9/29.
//
//

#import "PublicFunctions.h"
#import "DataFactory.h"


#define REGULAREXPRESSION_OPTION(regularExpression,regex,option) \
\
static inline NSRegularExpression * k##regularExpression() { \
static NSRegularExpression *_##regularExpression = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_##regularExpression = [[NSRegularExpression alloc] initWithPattern:(regex) options:(option) error:nil];\
});\
\
return _##regularExpression;\
}\


#define REGULAREXPRESSION(regularExpression,regex) REGULAREXPRESSION_OPTION(regularExpression,regex,NSRegularExpressionCaseInsensitive)


REGULAREXPRESSION(URLRegularExpression,@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)")

@implementation PublicFunctions
//#define PLIST_FILE_NAME @"CRM_refreshDateList.plist"

//单例化
+ (PublicFunctions *)sharedPublicFunctions {
    static PublicFunctions *sharedPublicFunctionsInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedPublicFunctionsInstance = [[self alloc] init];
    });
    return sharedPublicFunctionsInstance;
}

#pragma  mark HexColor转化为UIColor
/**
 @author SunJishuai , 15-07-01 14:07:31
 
 @brief  HexColor转化为iOS颜色数组或数值string
 
 @param hexColor    16进制
 
 @return UIColor
 */
- (UIColor *)colorForHex:(NSString *)hexColor
{
    hexColor = [[hexColor stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]
                 ] uppercaseString];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [hexColor substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return   [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0];
}

#pragma mark - 判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma  mark  003 判断是否是手机号码
/**
 @author SunJishuai, 15-07-08 23:07:08
 
 @brief  判断是否是手机号码
 
 @param phone 手机号
 
 @return 是--YES;  不是——NO
 */
- (BOOL) isPhoneNumber:(NSString *)phone
{
    NSString * MOBILE = @"(^1+\\d{10})|(^1+\\d{2}-(\\d{4})-(\\d{4}))|(((86)|(\\+86))1+((\\d{10})|(\\d{2}-(\\d{4})-(\\d{4}))))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phone];
}
#pragma  mark 004 判断是否是电话号码
/**
 @author SunJishuai, 15-07-08 23:07:11
 
 @brief  判断是否是电话号码
 
 @param tel 电话号码
 
 @return 是--YES;  不是——NO
 */
- (BOOL) isTelNumber:(NSString *)tel
{
    //优化：手机号码被判断为电话号码的BUG  
    if ([self isPhoneNumber:tel]) {
        return NO;
    }else {
        NSString *TEL = @"((^(\\d{3,4})-(\\d{7,8}))|(^(\\d{7,8}))|(^(\\d{3,4})(\\d{7,8})))$";
        NSPredicate *regextesttel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", TEL];
        return  [regextesttel evaluateWithObject:tel];
    }
}
#pragma  mark 005 load Image from caches dir or Documents to imageview
/**
 @author SunJishuai , 15-07-28 17:07:18
 
 @brief  load Image from caches dir or Documents to imageview
 
 @param directoryPath 照片存储路径
 @param imageName     照片名称
 
 @return 存储的data
 */
- (NSData*)loadImageDataWithPath:(NSString *) directoryPath andName: (NSString *)imageName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *imagePath = [directoryPath stringByAppendingString : imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : imagePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}
//006 get file from caches dir or Documents
- (BOOL)getFileWithPath:(NSString *) directoryPath andName: (NSString *)fileName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *filePath = [directoryPath stringByAppendingString : fileName];
        BOOL fileExisted = [fileManager fileExistsAtPath:filePath];
        if (!fileExisted) {
            return NO;
        }
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma  mark 007 判断密码是否有数字和字符组成
/**
 @author SunJishuai , 15-10-19 17:10:00
 
 @brief  判断密码是否有数字和字符组成
 
 @param password 密码
 
 @return YES or NO
 */
- (BOOL) isIncludeNumberAndChar:(NSString *)password
{
    NSString *PD = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *regextesttel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PD];
    return  [regextesttel evaluateWithObject:password];
}
#pragma  mark 008 判断密码是否只有数字组成
/**
 @author SunJishuai , 15-10-20 17:10:30
 
 @brief  判断密码是否只有数字组成
 
 @param password 密码
 
 @return YES or NO
 */
- (BOOL) isJuestIncludeNumber:(NSString *)password
{
    NSString *PD = @"^[0-9]*$";
    NSPredicate *regextesttel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PD];
    return  [regextesttel evaluateWithObject:password];
}
#pragma mark 009 除去字符串中的符号
/**
 @author SunJishuai , 15-10-23 10:10:38
 
 @brief  除去字符串中的符号
 
 @param str 字符串
 
 @return 除去符号后的字符串
 */
- (NSString *)deleteCharactersOfstring:(NSString *)str
{
    //由于NSString中有全角符号和半角符号, 因此有些符号要包括全角和半角的
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"，,。.?？！!"];
    return  [str stringByTrimmingCharactersInSet:set];
}

#pragma mark 009 处理时间戳的显示
/**
 @author Jesus  , 15-11-06 10:11:30
 
 @brief   如果是当天，则显示“HH:mm”,如果不是当天则显示“MM月dd日”
 
 @param idate 时间戳
 
 @return 要在页面上显示的时间
 */
- (NSString *)editDate:(double)idate{
    NSDate *nowDate=[NSDate date];
    NSDate *editDate=[NSDate dateWithTimeIntervalSince1970:idate];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *now = [NSString stringWithFormat:@"%@",[df stringFromDate:nowDate]];
    NSString *edit = [NSString stringWithFormat:@"%@",[df stringFromDate:editDate]];
    NSArray  *nowArray = [now componentsSeparatedByString:@" "];
    NSArray  *editArray = [edit componentsSeparatedByString:@" "];
    if([[nowArray objectAtIndex:0]isEqualToString:[editArray objectAtIndex:0]]){
        return [editArray lastObject];
    }else{
        return [[[editArray objectAtIndex:0]componentsSeparatedByString:@"年"]lastObject];
    }
}
//将时间戳转换成时间 -- 已经处理了与服务器的时间戳偏差
-(NSString *)dateTimeToString:(double)dateTime Type:(int)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    switch (type) {
        case 0:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case 1:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case 2:
            [formatter setDateFormat:@"HH:mm"];
        default:
            break;
    }
     // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    double ddd = (dateTime*24*3600*1000-2209190400000)/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:ddd];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

#pragma mark 014计算字符串的高度
/**
 @author Jesus          , 16-01-07 16:01:56
 
 @brief  计算字符串的高度
 
 @param width 宽度
 @param font  字号
 @param text  内容
 
 @return 大小
 */
- (CGSize)getHeightByWidth:(float)width Font:(UIFont *)font Text:(NSString *)text LineBreakMode:(NSLineBreakMode)breakMode{
    CGSize maximumLabelSizeOne = CGSizeMake(width,MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = breakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize contentSize = [text boundingRectWithSize:maximumLabelSizeOne options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return contentSize;
}

#pragma  mark 015按某一属性排序
/**
 @author Jesus , 16-01-13 09:01:12
 
 @brief 015按某一属性排序
 
 @param recordsArray 排序的数组
 @param property     用于排序的属性
 @param ascending    是否升序排列
 
 @return 返回排序好的数组
 */
- (NSMutableArray *)sortingArray:(NSMutableArray *)recordsArray Property:(NSString *)property Ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:property ascending:ascending];//其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [recordsArray sortUsingDescriptors:sortDescriptors];
    return recordsArray;
}

//016判断长网址
- (NSMutableArray *)isURL:(NSString *)text {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:text];
     NSRegularExpression * const regexps[] = {kURLRegularExpression()};
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    NSString *urlAction = @"url->";//kURLActions[i];
    NSMutableArray *results = [NSMutableArray array];
    [regexps[0] enumerateMatchesInString:[mutableAttributedString string] options:0 range:stringRange usingBlock:^(NSTextCheckingResult *result, __unused NSMatchingFlags flags, __unused BOOL *stop) {
        
        //检查是否和之前记录的有交集，有的话则忽略
        for (NSTextCheckingResult *record in results){
            if (NSMaxRange(NSIntersectionRange(record.range, result.range))>0){
                return;
            }
        }
        
        //添加链接
        NSString *actionString = [NSString stringWithFormat:@"%@%@",urlAction,[text substringWithRange:result.range]];
        
        //这里暂时用NSTextCheckingTypeCorrection类型的传递消息吧
        //因为有自定义的类型出现，所以这样方便点。
        NSTextCheckingResult *aResult = [NSTextCheckingResult correctionCheckingResultWithRange:result.range replacementString:actionString];
        
        [results addObject:aResult];
    }];
    return results;
}
//017 按需要生成图片文字按钮
/*
 type :0 默认图左字右
 type :1 图右字左
 type :2 图上字下
 type :3 图下字上 
 */
- (UIButton *)imageAndLabelButtonByType:(int)type Label:(NSString *)label LabelTextColor:(UIColor *)iColor NormalImage:(NSString *)normalImage SelectedImage:(NSString *)selectedImage Tag:(int)tag Frame:(CGRect)frame FontSize:(int)fontSize{
    UIButton * imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.tag = tag;
    [imageButton setBackgroundColor:[UIColor clearColor]];
    [imageButton.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [imageButton setTitleColor:iColor forState:UIControlStateNormal];
    [imageButton setTitleColor:tabbarSelectTextColor forState:UIControlStateSelected];
    [imageButton setTitle:label forState:UIControlStateNormal];
    imageButton.frame =frame;
    imageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [imageButton setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [imageButton setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    switch (type) {
        case 0:
            break;
        case 1:
        {
            CGSize labelSize = [label sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];// sizeWithFont:[UIFont systemFontOfSize:fontSize]];
            [imageButton setImageEdgeInsets:UIEdgeInsetsMake(0,labelSize.width,0,0)];
            [imageButton setTitleEdgeInsets:UIEdgeInsetsMake(0,-labelSize.width,0,0)];
        }
            break;
        case 2:
        {//图片在button中是按照原尺寸显示的
            CGSize labelSize = [label sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
            [imageButton setImageEdgeInsets:UIEdgeInsetsMake(5,labelSize.width,labelSize.height+5,0)];
            [imageButton setTitleEdgeInsets:UIEdgeInsetsMake(30,-[UIImage imageNamed:normalImage].size.width,0,0)];
        }
            break;
        case 3:
        {
            [imageButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,frame.size.height*0.5,0)];
//            [imageButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,frame.size.height*0.5,0)];
        }
            break;
        default:
            break;
    }
    return  imageButton;
}




//压缩算法
- (CGRect)ReduceMethodForBackGroundSize:(CGSize)bgSize rectSize:(CGSize)rectSize
{
    if ((rectSize.width<bgSize.width)&&(rectSize.height<bgSize.height)) {
        return CGRectMake(bgSize.width/2-rectSize.width/2, bgSize.height/2-rectSize.height/2, rectSize.width, rectSize.height);
    }
    else if((rectSize.width>bgSize.width)&&(rectSize.height<bgSize.height))
    {
        float rate = rectSize.width/bgSize.width;
        return CGRectMake(0, bgSize.height/2-rectSize.height/rate/2, bgSize.width, rectSize.height/rate);
    }
    else if((rectSize.width<bgSize.width)&&(rectSize.height>bgSize.height))
    {
        float rate = rectSize.height/bgSize.height;
        return CGRectMake(bgSize.width/2-rectSize.width/rate/2, 0, rectSize.width/rate, bgSize.height);
    } else if((rectSize.width==bgSize.width)&&(rectSize.height==bgSize.height))
    {
        return CGRectMake(0, 0, bgSize.width, bgSize.height);
    }
    else if((rectSize.width<bgSize.width)&&(rectSize.height==bgSize.height))
    {
        return CGRectMake(bgSize.width/2-rectSize.width/2, 0, rectSize.width, rectSize.height);
    }
    else if((rectSize.width==bgSize.width)&&(rectSize.height<bgSize.height))
    {
        return CGRectMake(0, bgSize.height/2-rectSize.height/2, rectSize.width, rectSize.height);
    }
    else
    {
        float widthRate = rectSize.width/bgSize.width;
        float heightRate = rectSize.height/bgSize.height;
        if (widthRate>heightRate) {
            return CGRectMake(0, bgSize.height/2-rectSize.height/widthRate/2, bgSize.width, bgSize.height/widthRate);
        }
        else if(widthRate<heightRate)
        {
            return CGRectMake(bgSize.width/2-rectSize.width/heightRate/2, 0, bgSize.width/heightRate, bgSize.height);
        }
        else
        {
            return CGRectMake(0, 0, bgSize.width, bgSize.height);
        }
    }
    return CGRectMake(0, 0, 0, 0);
}

#pragma  mark 图片翻转
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    
    long double rotate = 0.0;
    
    CGRect rect;
    
    float translateX = 0;
    
    float translateY = 0;
    
    float scaleX = 1.0;
    
    float scaleY = 1.0;
    
    
    
    switch (orientation) {
            
        case UIImageOrientationLeft:
            
            rotate = M_PI_2;
            
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            
            translateX = 0;
            
            translateY = -rect.size.width;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationRight:
            
            rotate = 3 * M_PI_2;
            
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            
            translateX = -rect.size.height;
            
            translateY = 0;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationDown:
            
            rotate = M_PI;
            
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            translateX = -rect.size.width;
            
            translateY = -rect.size.height;
            
            break;
            
        default:
            
            rotate = 0.0;
            
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            translateX = 0;
            
            translateY = 0;
            
            break;
            
    }
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //做CTM变换
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX, translateY);
    
    
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    return newPic;
    
}

#pragma  mark 按提醒时间顺序排序记录

- (NSMutableArray *)sortingArrayByTime:(NSMutableArray *)recordsArray
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"warnTime" ascending:NO];//其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [recordsArray sortUsingDescriptors:sortDescriptors];
    return recordsArray;
}

#pragma  mark 根据文件类型显示文件
/**
 @author SunJishuai , 15-08-28 17:08:00
 
 @brief  根据文件类型显示文件
 
 @param fileImage 显示控件
 @param fileName  文件名
 @param path      文件路径
 */
- (void)showAnnexWith:(UIImageView *)imgView FileName:(NSString *)fileName FilePath:(NSString *)filePath
{
    NSArray *fileType=[[NSArray alloc] initWithObjects:@".png",@".gif",@".jpg",@".mp3",@".doc",@".docx",@".pdf",@".mp4",@".wav",@".txt",@".xls",@".xlsx",@".ppt",@".pptx",@".bmp",nil] ;
    //根据不同的文件类型，设置不同类型的文件图片
    for (int i=0; i<fileType.count; i++) {
        NSString *str=[fileType objectAtIndex:i];
        NSRange range = [fileName rangeOfString:str];
        int file_lenght=(int)fileName.length;//文件名称的总长度
        int str_location = (int)range.location;//后缀在全名称中的起始位置
        int str_lenght = (int)range.length;//后缀在全名称中的长度
        
        if (file_lenght==(str_lenght+str_location) && ([str isEqual:@".png"]||[str isEqual:@".gif"]||[str isEqual:@".jpg"]||[str isEqual:@".bmp"])) {
            //如果本地存在照片，读出显示
            //附件保存在Document/doc文件夹下
            //附件的path在协议处理时是本地路径，但是服务器返回时是服务器上文件的路径，用于下载
            NSData *imageData = [self loadImageDataWithPath:[NSString stringWithFormat:@"%@/docs/",[SandboxFile GetDocumentPath]] andName:fileName];
            if(imageData)
            {
                imgView.image = [UIImage imageWithData:imageData];
            }
            //如果不存在根据类型生成头像
            else{
                imgView.image  = [UIImage imageNamed:@"icon"];
            }            break;
        }
        if (file_lenght==(str_lenght+str_location) && ([str isEqual:@".mp3"]||[str isEqual:@".wav"])) {
            imgView.image=[UIImage imageNamed:@"file_music"];
            break;
        }
        if (file_lenght==(str_lenght+str_location) && ([str isEqual:@".doc"]||[str isEqual:@".docx"])) {
            imgView.image=[UIImage imageNamed:@"file_doc"];
            break;
        }
        if (file_lenght==(str_lenght+str_location) && [str isEqual:@".pdf"]) {
            imgView.image=[UIImage imageNamed:@"file_PDF"];
            break;
        }
        if (file_lenght==(str_lenght+str_location) && [str isEqual:@".mp4"]) {
            imgView.image=[UIImage imageNamed:@"file_video"];
            break;
        }
        if (file_lenght==(str_lenght+str_location) && ([str isEqual:@".ppt"]||[str isEqual:@".pptx"])) {
            imgView.image=[UIImage imageNamed:@"file_ppt"];
            break;
        }
        if (file_lenght==(str_lenght+str_location) && [str isEqual:@".txt"]) {
            imgView.image=[UIImage imageNamed:@"file_text"];
            break;
        }
        if (file_lenght==(str_lenght+str_location) && ([str isEqual:@".xls"]||[str isEqual:@".xlsx"])) {
            imgView.image=[UIImage imageNamed:@"file_excel"];
            break;
        }
        else {
            imgView.image=[UIImage imageNamed:@"file_other"];
        }
    }
}
#pragma  mark 获取文件的类型
/**
 @author SunJishuai , 15-08-29 09:08:07
 
 @brief  获取文件的类型
 
 @param fileName 文件名称
 */
- (int)getTypeOfFileName:(NSString *)fileName
{
    NSArray *fileType=[[NSArray alloc] initWithObjects:@".png",@".gif",@".jpg",@".mp3",@".doc",@".docx",@".pdf",@".mp4",@".wav",@".txt",@".xls",@".xlsx",@".ppt",@".pptx",@".bmp",nil];
    for (int i=0; i<fileType.count; i++) {
        NSString *str=[fileType objectAtIndex:i];
        NSRange range = [fileName rangeOfString:str];
        int file_lenght=(int)fileName.length;//文件名称的总长度
        int str_location = (int)range.location;//后缀在全名称中的起始位置
        int str_lenght = (int)range.length;//后缀在全名称中的长度
        
        if (file_lenght==(str_lenght+str_location) && ([str isEqual:@".png"]||[str isEqual:@".gif"]||[str isEqual:@".jpg"]||[str isEqual:@".bmp"])) {
            return 1;
        }
    }
    return 0;
}


@end
