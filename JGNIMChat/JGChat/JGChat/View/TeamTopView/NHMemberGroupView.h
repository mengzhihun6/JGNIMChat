//
//  NHMemberGroupView.h
//  NestHouse
//
//  Created by JG on 2017/5/4.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NIMCardDataSourceProtocol.h"

@protocol NHMemberGroupViewDelegate <NSObject>
@optional

- (void)didSelectMemberId:(NSString *)uid;

- (void)didSelectRemoveButtonWithMemberId:(NSString *)uid;

- (void)didSelectOperator:(NIMKitCardHeaderOpeator )opera;

@end

@interface NHMemberGroupView : UIView

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,readonly) BOOL showAddOperator;

@property (nonatomic,readonly) BOOL showRemoveOperator;

@property (nonatomic,assign) BOOL enableRemove;

@property (nonatomic,weak) id<NHMemberGroupViewDelegate> delegate;

- (void)refreshUids:(NSArray *)uids operators:(NIMKitCardHeaderOpeator)operators;

- (void)setTitle:(NSString *)title forOperator:(NIMKitCardHeaderOpeator)opera;

@end
