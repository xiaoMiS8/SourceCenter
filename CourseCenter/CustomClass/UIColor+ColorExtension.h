//
//  UIColor+ColorExtension.h
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorExtension)

    //十六进制颜色转化为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
