//
//  JGChatConfig.h
//  JGChat
//
//  Created by JG on 2017/5/11.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGChatConfig : NSObject


+ (instancetype)sharedConfig;

@property (nonatomic,copy)  NSString    *appKey;
@property (nonatomic,copy)  NSString    *apiURL;
@property (nonatomic,copy)  NSString    *cerName;

@end
