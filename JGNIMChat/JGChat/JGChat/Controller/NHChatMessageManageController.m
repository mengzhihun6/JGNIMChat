//
//  NHChatMessageManageController.m
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHChatMessageManageController.h"
#import "NHChatMessageManageView.h"
#import "NHSessionChatHistoryController.h"


@interface NHChatMessageManageController ()<NHChatMessageManageViewDelegate>

@property (nonatomic, strong) NHChatMessageManageView *chatManageView;

@property (nonatomic,strong) NIMSession *session;

@end

@implementation NHChatMessageManageController

- (instancetype)initWithSession:(NIMSession *)session{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _session = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"聊天信息";
    [self firstLoading];
    
}

#pragma mark - firstLoading
- (void)firstLoading{
    self.chatManageView = [[NHChatMessageManageView alloc]initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT - kMarginTopHeight)];
    self.chatManageView.delegate = self;
    [self.view addSubview:self.chatManageView];
}

#pragma mark - NHChatMessageManageViewDelegate
- (void)searchButClick:(NHChatMessageManageView *)view{
    DLog(@"点击了查找按钮");
    NHSessionChatHistoryController *vc = [[NHSessionChatHistoryController alloc]initWithSession:_session];
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (void)cleanButClick:(NHChatMessageManageView *)view{
    DLog(@"点击了清理按钮");
}

@end
