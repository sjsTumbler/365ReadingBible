//
//  NSString+SizeString.h
//  Reading365
//
//  Created by ccSunday on 16/2/25.
//  Copyright © 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SizeString)
///固定宽
+ (CGSize)getSizeWithString:(NSString *)content andWidth:(CGFloat)width andFont:(UIFont *)font;

///固定高
+ (CGSize)getSizeWithString:(NSString *)content andHeight:(CGFloat)height andFont:(UIFont *)font;

///固定宽，限制高
+ (CGSize)getSizeWithString:(NSString *)content andWidth:(CGFloat)width andFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;

///固定高，限制宽
+ (CGSize)getSizeWithString:(NSString *)content andHeight:(CGFloat)height andFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

@end
