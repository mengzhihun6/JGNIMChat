//
//  UIView+ChangeSize.m
//  ContactExercise
//
//  Created by 123 on 14/12/31.
//  Copyright (c) 2014年 QYQ. All rights reserved.
//

#import "UIView+ChangeSize.h"

@implementation UIView (ChangeSize)

+(CGRect)setFrame:(CGRect)frame{
    float a=[UIView setWidth:frame.origin.x];
    float b=[UIView setHeight:frame.origin.y];
    float c=[UIView setWidth:frame.size.width];
    float d=[UIView setHeight:frame.size.height];
    CGRect frame1=CGRectMake(a, b, c, d);
    return frame1;
    
}
+(float)setWidth:(float)width
{
    
    return width*WRATIO;
    
}

+(float)setHeight:(float)height
{
    
    return height*HRATIO;
}

+ (float)setMWidth:(float)width
{
    return width* MaxWRATIO;
}
+ (float)setMHeight:(float)height
{
    return height * MaxHRATIO;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


@end
