//
//  UILabel+HJGLableFit.h
//  HJGTodayNews
//
//  Created by JG on 2017/1/12.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HJGLableFit)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

+ (UILabel *)lableWithTextColor:(UIColor *)textColor textFont:(CGFloat)font text:(NSString *)text;

@end
