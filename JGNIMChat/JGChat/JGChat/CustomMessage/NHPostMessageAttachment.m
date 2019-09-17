//
//  NHPostMessageAttachment.m
//  NestHouse
//
//  Created by JG on 2017/4/28.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHPostMessageAttachment.h"

@implementation NHPostMessageAttachment

- (NSString *)encodeAttachment
{
    NSDictionary *dictContent = @{CMPostImageUrl: self.postImageUrl,CMPostContent:self.postContent,CMPostTopic: self.postTopic};
    NSDictionary *dict = @{CMType: @(CustomMessagePost), CMData: dictContent};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:nil];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

- (NSString *)postTopic{
    if (!_postTopic) {
        _postTopic = @"来自话题.晒晒我家的早餐";
    }
    return _postTopic;
}

- (NSString *)postContent{
    if (!_postContent) {
        _postContent = @"我家的早餐，好吃的不得了，真他妈的好吃，我都吃胖了";
    }
    return _postContent;
}

- (NSString *)postImageUrl{
    if (!_postImageUrl) {
        _postImageUrl = @"http://img.wxcha.com/file/201704/22/f9d536efdb.gif";
    }
    
    return _postImageUrl;

}

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width {
    return CGSizeMake(170, 100);
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
    return @"NHPostMessageContentView";
}

@end
