//
//  NHLocationAttachment.m
//  NestHouse
//
//  Created by JG on 2017/4/28.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHLocationAttachment.h"

@implementation NHLocationAttachment

- (NSString *)encodeAttachment
{
    NSDictionary *dictContent = @{CMLocationMapImageUrl: self.mapImageUrl,CMLocationMapAdress:self.mapAdress,CMLocationMapAdressDetail: self.mapAdressDetail};
    NSDictionary *dict = @{CMType: @(CustomMessageLocation), CMData: dictContent};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:nil];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

- (NSString *)mapAdress{
    if (!_mapAdress) {
        _mapAdress = @"新罗马皇宫";
    }
    return _mapAdress;

}

- (NSString *)mapAdressDetail{
    if (!_mapAdressDetail) {
        _mapAdressDetail = @"江苏省南通市崇川区濠西路28号";
    }
    return _mapAdressDetail;
}

- (NSString *)mapImageUrl{
    if (!_mapImageUrl) {
        _mapImageUrl = @"http://img.wxcha.com/file/201704/22/f9d536efdb.gif";
    }
    
    return _mapImageUrl;
    
}

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width {
    return CGSizeMake(170, 130);
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
    return @"NHMapMessageContentView";
}

@end
