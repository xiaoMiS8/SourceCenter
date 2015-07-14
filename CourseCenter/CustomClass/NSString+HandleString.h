//
//  NSString+HandleString.h
//  CourseCenter
//
//  Created by muzhenhua on 15/5/14.
//  Copyright (c) 2015年 line0.com.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (HandleString)
-(NSMutableString *)deleteStrWithSub:(NSString *)sub;
-(NSString *)MD5Hash;
-(NSString *)cutString:(NSInteger )index;
-(NSString *)changeStringWithStr:(NSString *)str;
-(NSArray *)carveNSStringWithStr:(NSString *)str;
-(NSString *)removeHtmlLanguage;
-(BOOL)isNull;
@end
