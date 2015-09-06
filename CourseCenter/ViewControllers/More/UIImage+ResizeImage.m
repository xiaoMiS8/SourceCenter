//
//  UIImage+ResizeImage.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//
#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

@end
