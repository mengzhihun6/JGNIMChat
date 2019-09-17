//
//  JGChatConfig.m
//  JGChat
//
//  Created by JG on 2017/5/11.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGChatConfig.h"

@implementation JGChatConfig

+ (instancetype)sharedConfig
{
    static JGChatConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JGChatConfig alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _appKey = CHATKEY;
        _apiURL = @"https://app.netease.im/api";
        _cerName= @"ENTERPRISE";
    }
    return self;
}

- (NSString *)appKey
{
    return _appKey;
}

- (NSString *)apiURL
{
    return _apiURL;
}

- (NSString *)cerName
{
    return _cerName;
}


@end
