//
//  NHSearchChatHistoryObject.h
//  NestHouse
//
//  Created by JG on 2017/4/27.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NHSearchLocalHistoryType){
    SearchLocalHistoryTypeEntrance,
    SearchLocalHistoryTypeContent,
};

@class NHSearchChatHistoryObject;
@protocol NHSearchObjectRefresh <NSObject>

- (void)refresh:(NHSearchChatHistoryObject *)object;

@end

@interface NHSearchChatHistoryObject : NSObject

@property (nonatomic,copy)   NSString *content;

@property (nonatomic,assign) CGFloat uiHeight;

@property (nonatomic,assign) NHSearchLocalHistoryType type;

@property (nonatomic,readonly) NIMMessage *message;

- (instancetype)initWithMessage:(NIMMessage *)message;


@end
