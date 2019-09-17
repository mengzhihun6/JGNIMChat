//
//  NHSessionUtil.h
//  NestHouse
//
//  Created by JG on 2017/4/27.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHSessionUtil : NSObject

+ (CGSize)getImageSizeWithImageOriginSize:(CGSize)originSize
                                  minSize:(CGSize)imageMinSize
                                  maxSize:(CGSize)imageMaxSize;

//接收时间格式化
+ (NSString*)showTime:(NSTimeInterval) msglastTime showDetail:(BOOL)showDetail;

+ (NSString *)showNick:(NSString*)uid inSession:(NIMSession*)session;

@end
