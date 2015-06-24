//
//  UIView+HandleView.m
//  CourseCenter
//
//  Created by muzhenhua on 15/5/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "UIView+HandleView.h"

@implementation UIView (HandleView)

/**
 *	@brief	获取uiview所在的试图控制器
 *
 *	@return	根视图控制器
 */
-(UIViewController *)getRootViewController

{
    for (UIView *next=[self superview]; next; next=next.superview) {
        UIResponder *nextResponder=[next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
