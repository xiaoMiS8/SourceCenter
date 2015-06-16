//
//  MyTextView.h
//  HiBit
//
//  Created by jian on 14-6-27.
//  Copyright (c) 2014年 Steel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;     //占位符

-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知

@property (nonatomic ,strong)UILabel *placeholderLabel;

@end

