//
//  NHSessionConfigurator.m
//  NestHouse
//
//  Created by JG on 2017/4/24.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHSessionConfigurator.h"
#import "NIMSessionMsgDatasource.h"
#import "NIMSessionInteractorImpl.h"
#import "NIMCustomLeftBarView.h"
#import "UIView+NIM.h"
#import "NIMKitUIConfig.h"
#import "NIMMessageModel.h"
#import "NIMGlobalMacro.h"
#import "NIMSessionInteractorImpl.h"
#import "NIMSessionDataSourceImpl.h"
#import "NIMSessionLayoutImpl.h"
#import "NHSessionTableAdapter.h"
@interface NHSessionConfigurator()


@property (nonatomic,strong) NIMSessionInteractorImpl   *interactor;

@property (nonatomic,strong) NHSessionTableAdapter     *tableAdapter;

@end

@implementation NHSessionConfigurator


- (void)setup:(NIMSessionViewController *)vc
{
    NIMSession *session    = vc.session;
    id<NIMSessionConfig> sessionConfig = vc.sessionConfig;
    UITableView *tableView = vc.tableView;
    
    NIMSessionDataSourceImpl *datasource = [[NIMSessionDataSourceImpl alloc] initWithSession:session config:sessionConfig];
    NIMSessionLayoutImpl *layout         = [[NIMSessionLayoutImpl alloc] initWithSession:session tableView:tableView config:sessionConfig];
    
    
    _interactor                          = [[NIMSessionInteractorImpl alloc] initWithSession:session config:sessionConfig];
    _interactor.delegate                 = vc;
    _interactor.dataSource               = datasource;
    _interactor.layout                   = layout;
    
    _tableAdapter = [[NHSessionTableAdapter alloc] init];
    _tableAdapter.interactor = _interactor;
    _tableAdapter.delegate   = vc;
    //传入sessionID，为了判断是群还是个人聊天。从而判断是否头部有订单header
    _tableAdapter.session = self.session;
    vc.tableView.delegate = _tableAdapter;
    vc.tableView.dataSource = _tableAdapter;
    
    
    [vc setInteractor:_interactor];
}

@end
