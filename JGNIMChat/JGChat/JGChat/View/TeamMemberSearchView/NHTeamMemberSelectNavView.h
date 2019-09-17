//
//  NHTeamMemberSelectNavView.h
//  NestHouse
//
//  Created by JG on 2017/4/21.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTeamMemberSelectNavView;
@protocol NHTeamMemberSelectNavViewDelegate <NSObject>

- (void)selectNavCollectionCell;

@end

@interface NHTeamMemberSelectNavView : UIView

//collocation
@property (nonatomic, strong) UICollectionView *memberCollectionView;

//UITextField
@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) NSMutableArray *dataArry;

@property (nonatomic, strong) id<NHTeamMemberSelectNavViewDelegate> delegate;

@end
