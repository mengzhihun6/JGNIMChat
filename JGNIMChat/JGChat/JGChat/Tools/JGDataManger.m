//
//  JGDataManger.m
//  JGChat
//
//  Created by JG on 2017/5/11.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGDataManger.h"
@interface JGDataManger()<NIMUserManagerDelegate,NIMTeamManagerDelegate>

@end

@implementation JGDataManger

+ (instancetype)sharedInstance{
    static JGDataManger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JGDataManger alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _defaultUserAvatar = [UIImage imageNamed:@"DefaultAvatar"];
        _defaultTeamAvatar = [UIImage imageNamed:@"avatar_team"];
        
        [[NIMSDK sharedSDK].userManager addDelegate:self];
        [[NIMSDK sharedSDK].teamManager addDelegate:self];
    }
    return self;
}


- (void)dealloc
{
    [[NIMSDK sharedSDK].userManager removeDelegate:self];
}

- (NIMKitInfo *)infoByUser:(NSString *)userId
                 inSession:(NIMSession *)session
{
    BOOL needFetchInfo = NO;
    NIMSessionType sessionType = session.sessionType;
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.infoId = userId;
    info.showName = userId; //默认值
    switch (sessionType) {
        case NIMSessionTypeP2P:
        case NIMSessionTypeTeam:
        {
            NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
            NIMUserInfo *userInfo = user.userInfo;
            NIMTeamMember *member = nil;
            if (sessionType == NIMSessionTypeTeam)
            {
                member = [[NIMSDK sharedSDK].teamManager teamMember:userId
                                                             inTeam:session.sessionId];
            }
            NSString *name = [self nickname:user
                                 memberInfo:member];
            if (name)
            {
                info.showName = name;
            }
            info.avatarUrlString = userInfo.thumbAvatarUrl;
            info.avatarImage = self.defaultUserAvatar;
            
            if (userInfo == nil)
            {
                needFetchInfo = YES;
            }
        }
            break;
        case NIMSessionTypeChatroom:
            NSAssert(0, @"invalid type"); //聊天室的Info不会通过这个回调请求
            break;
        default:
            NSAssert(0, @"invalid type");
            break;
    }
    
    return info;
}

#pragma mark - nickname
- (NSString *)nickname:(NIMUser *)user
            memberInfo:(NIMTeamMember *)memberInfo
{
    NSString *name = nil;
    do{
        if ([user.alias length])
        {
            name = user.alias;
            break;
        }
        if (memberInfo && [memberInfo.nickname length])
        {
            name = memberInfo.nickname;
            break;
        }
        
        if ([user.userInfo.nickName length])
        {
            name = user.userInfo.nickName;
            break;
        }
    }while (0);
    return name;
}


- (NIMKitInfo *)infoByTeam:(NSString *)teamId
{
    NIMTeam *team    = [[NIMSDK sharedSDK].teamManager teamById:teamId];
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.showName    = team.teamName;
    info.infoId      = teamId;
    info.avatarImage = self.defaultTeamAvatar;
    info.avatarUrlString = team.thumbAvatarUrl;
    return info;
}

- (NIMKitInfo *)infoByUser:(NSString *)userId
               withMessage:(NIMMessage *)message
{
    return [self infoByUser:userId
                  inSession:message.session];
    
}

- (NSString *)tipMessage:(NIMMessage *)message
{
    NSString *text = nil;
    
    return text;
}



#pragma mark - NIMUserManagerDelegate

- (void)onFriendChanged:(NIMUser *)user
{
    [[NIMKit sharedKit] notfiyUserInfoChanged:@[user.userId]];
}

- (void)onUserInfoChanged:(NIMUser *)user
{
    [[NIMKit sharedKit] notfiyUserInfoChanged:@[user.userId]];
}


@end
