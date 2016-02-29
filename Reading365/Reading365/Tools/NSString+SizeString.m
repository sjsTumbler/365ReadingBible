//
//  NSString+SizeString.m
//  Reading365
//
//  Created by ccSunday on 16/2/25.
//  Copyright © 2016年 SunJishuai. All rights reserved.
//

#import "NSString+SizeString.h"

@implementation NSString (SizeString)
+ (CGSize)getSizeWithString:(NSString *)content andWidth:(CGFloat)width andFont:(UIFont *)font
{
    CGSize maxSize=CGSizeMake(width, 99999);
    CGSize  strSize=[content sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    return strSize;
    
}

+ (CGSize)getSizeWithString:(NSString *)content andHeight:(CGFloat)height andFont:(UIFont *)font
{
    CGSize maxSize=CGSizeMake(99999, height);
    CGSize  strSize=[content sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    return strSize;
}

+ (CGSize)getSizeWithString:(NSString *)content andHeight:(CGFloat)height andFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    CGSize maxSize=CGSizeMake(99999, height);
    CGSize  strSize=[content sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    if (strSize.width > maxWidth) {
        strSize.width = maxWidth;
    }
    return strSize;
}

+ (CGSize)getSizeWithString:(NSString *)content andWidth:(CGFloat)width andFont:(UIFont *)font maxHeight:(CGFloat)maxHeight
{
    CGSize maxSize=CGSizeMake(width, 99999);
    CGSize  strSize=[content sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    if (strSize.height > maxHeight) {
        strSize.height = maxHeight;
    }
    return strSize;
}

@end
