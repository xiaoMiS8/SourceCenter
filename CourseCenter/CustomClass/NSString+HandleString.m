//
//  NSString+HandleString.m
//  CourseCenter
//
//  Created by muzhenhua on 15/5/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NSString+HandleString.h"

@implementation NSString (HandleString)
/**
 *	@brief	查找字符串中的指定字符并删除
 *
 *	@param 	sub 	指定字符传
 *
 *	@return	处理后的字符串
 */
-(NSMutableString *)deleteStrWithSub:(NSString *)sub

{
     NSMutableString *mStr=[NSMutableString stringWithString:self];
    //字符串查找,可以判断字符串中是否有
    for (int i=0; i<mStr.length; i++) {
        //查找并删除
        NSRange substr = [mStr rangeOfString:sub];
        if (substr.location != NSNotFound) {
            [mStr deleteCharactersInRange:substr];
        }
    }
    return mStr;
}
/**
 *	@brief	MD5加密
 *
 *	@return	加密后的字符串
 */
- (NSString *)MD5Hash

{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
/**
 *	@brief	截取指定位置指定个数的字符串
 *
 *	@param 	index 	截取字符串的个数
 *
 *	@return	截取出来的字符串
 */
-(NSString *)cutString:(NSInteger )index
{
    NSInteger startindex=self.length;
    NSString *stringF=[self substringWithRange:NSMakeRange(startindex-4, index)];
    return stringF;
}
//保留字符串特定位
/**
 *	@brief	保留字符串特定位(由特殊字符决定)
 *
 *	@param 	str 特殊字符
 *
 *	@return	保留后的字符串
 */
-(NSString *)changeStringWithStr:(NSString *)str

{
    NSRange range=[self rangeOfString:str];
    NSString *string=nil;
    if (self.length<range.location+3) {
        string=[self substringToIndex:self.length];
    }else
    {
        string=[self substringToIndex:range.location+3];
    }
    return string;
}
/**
 *	@brief	以字符串中的字符作为分割条件进行分割
 *
 *	@param 	str  条件字符
 *
 *	@return	分割后的字符串数组
 */
-(NSArray *)carveNSStringWithStr:(NSString *)str

{
    //以字符串中的字符作为分割条件进行分割
    NSArray * array = [self componentsSeparatedByCharactersInSet:[NSCharacterSet                                            characterSetWithCharactersInString:str]];
    return array;
}

/**
 *	@brief	Html标签解析
 *
 *	@return	解析后的标签
 */
-(NSString *)removeHtmlLanguage

{
    NSString *str=self;
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    NSString*str1=[str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return str1;
    
}
@end
