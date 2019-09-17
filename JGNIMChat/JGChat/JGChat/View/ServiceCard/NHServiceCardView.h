//
//  NHServiceCardView.h
//  NestHouse
//
//  Created by JG on 2017/4/25.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHServiceCardView;
@protocol NHServiceCardViewDelegate <NSObject>

- (void)backViewClick:(NHServiceCardView *)backView;

@end

@interface NHServiceCardView : UIView

@property (nonatomic, strong) id<NHServiceCardViewDelegate> delegate;

@end
