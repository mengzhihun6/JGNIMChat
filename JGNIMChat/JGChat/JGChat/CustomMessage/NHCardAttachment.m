//
//  NHCardAttachment.m
//  NestHouse
//
//  Created by JG on 2017/4/21.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHCardAttachment.h"

@implementation NHCardAttachment

- (NSString *)encodeAttachment
{
    NSDictionary *dictContent = @{CMIdentificationImageUrl: self.identificantionImageUrl, CMIdentificationIntro: self.identificantionIntro, CMIdentificationPhoneNum: self.phoneNumber};
    NSDictionary *dict = @{CMType: @(CustomMessageTypeIdentificantionCard), CMData: dictContent};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:nil];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

- (NSString *)identificantionImageUrl{
    if (!_identificantionImageUrl) {
        _identificantionImageUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493082723&di=f8827ffdb2a09977394910cece74e1cc&src=http://i2.sanwen8.cn/doc/1610/704-161024214100.jpg";
    }
    return _identificantionImageUrl;

}

- (NSString *)identificantionIntro{
    if (!_identificantionIntro) {
        _identificantionIntro = @"健身卡傲娇卅空间暗红色的看见爱上课";
    }
    return _identificantionIntro;
}

- (NSString *)phoneNumber{
 
    if (!_phoneNumber) {
        _phoneNumber = @"15996667281";
    }
    return _phoneNumber;
}

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width {
    return CGSizeMake(160, 190);
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
    return @"NHIdentCardMessageContentView";
}


@end
