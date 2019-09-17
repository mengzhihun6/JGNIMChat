//
//  NHSessionTableAdapter.m
//  NestHouse
//
//  Created by JG on 2017/4/22.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHSessionTableAdapter.h"
#import "NHSessionTopHeaderView.h"
@interface NHSessionTableAdapter()

@property (nonatomic, strong) NHSessionTopHeaderView *topHeaderView;

@end

@implementation NHSessionTableAdapter


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat headerHeight = 0;
    NIMSessionType type = self.session.sessionType;
    switch (type) {
        case NIMSessionTypeTeam:{

            headerHeight = 100;
        }
            break;
        case NIMSessionTypeP2P:{
            headerHeight = 0;
        }
            break;
        default:
            break;
    }
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setHeader];
}

- (UIView *)setHeader{
    if (_topHeaderView == nil) {
        _topHeaderView = [[NHSessionTopHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    }
    return _topHeaderView;
}

@end
