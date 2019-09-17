//
//  UILabel+HJGLableFit.m
//  HJGTodayNews
//
//  Created by JG on 2017/1/12.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "UILabel+HJGLableFit.h"

@implementation UILabel (HJGLableFit)


+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

+ (UILabel *)lableWithTextColor:(UIColor *)textColor textFont:(CGFloat)font text:(NSString *)text{
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = textColor;
    lable.font = [UIFont systemFontOfSize:font];
    lable.text = text;
    return lable;

}




@end
