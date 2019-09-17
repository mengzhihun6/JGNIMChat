//
//  NHMaterialGifAttachment.m
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHMaterialGifAttachment.h"

@implementation NHMaterialGifAttachment

- (NSString *)encodeAttachment
{
    NSDictionary *dictContent = @{CMMaterialGifUrl: self.gifUrl};
    NSDictionary *dict = @{CMType: @(CustomMessageMaterialGif), CMData: dictContent};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:nil];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

- (NSString *)gifUrl{
    if (!_gifUrl) {
        _gifUrl = @"http://img.wxcha.com/file/201704/22/f9d536efdb.gif";
    }
    return _gifUrl;
}

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width {
    return CGSizeMake(160, 120);
}

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message {
    CGFloat bubblePaddingForImage    = 3.f;
    CGFloat bubbleArrowWidthForImage = 5.f;
    if (message.isOutgoingMsg) {
        return  UIEdgeInsetsMake(bubblePaddingForImage,bubblePaddingForImage,bubblePaddingForImage,bubblePaddingForImage + bubbleArrowWidthForImage);
    }else{
        return  UIEdgeInsetsMake(bubblePaddingForImage,bubblePaddingForImage + bubbleArrowWidthForImage, bubblePaddingForImage,bubblePaddingForImage);
    }
}

- (NSString *)cellContent:(NIMMessage *)message{
    return @"NHMaterialGifMessageContentView";
}

@end
