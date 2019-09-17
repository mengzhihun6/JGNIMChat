//
//  NHChatMessageManageView.h
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHChatMessageManageView;
@protocol NHChatMessageManageViewDelegate <NSObject>

- (void)searchButClick:(NHChatMessageManageView *)view;

- (void)cleanButClick:(NHChatMessageManageView *)view;

@end

@interface NHChatMessageManageView : UIView

@property (nonatomic, weak) id<NHChatMessageManageViewDelegate> delegate;

@end
