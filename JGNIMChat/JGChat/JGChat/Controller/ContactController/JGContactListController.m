//
//  JGContactListController.m
//  JGChat
//
//  Created by JG on 2017/5/12.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGContactListController.h"
#import "JGContactListCell.h"
#import "NIMGroupedUsrInfo.h"
#define KContactListCell @"KContactListCell"
@interface JGContactListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *contactList;

@property (nonatomic, strong) NSMutableArray *arrData;

//已选数组
@property (nonatomic, strong) NSMutableArray *selectedArr;

@property (nonatomic, strong) UIButton *rightBut;

//好友id数组
@property (nonatomic, strong) NSMutableArray *idArr;

@property (nonatomic, strong) NSMutableArray *animationLayers;
@property (nonatomic, assign) BOOL isNeedNotification;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation JGContactListController

- (NSMutableArray *)idArr{
    if (!_idArr) {
        _idArr = [NSMutableArray array];
    }
    return _idArr;
}

- (NSMutableArray *)arrData{
    if (!_arrData) {
        _arrData = [[NSMutableArray alloc]init];
    }
    return _arrData;
}

- (NSMutableArray *)selectedArr{
    if (!_selectedArr) {
        _selectedArr = [[NSMutableArray alloc]init];
    }
    return _selectedArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //获取好友列表
    [self getMyFriendsList];
    [self rightNavBut];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contactList.backgroundColor = [UIColor whiteColor];
}

- (void)rightNavBut{
    self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBut.frame = CGRectMake(0, 7, 50, 30);
    [self.rightBut setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBut addTarget:self action:@selector(rightButClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBut];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 点击发起聊天
- (void)rightButClick{
    if (self.selectedArr.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NIMCreateTeamOption *option = [[NIMCreateTeamOption alloc]init];
        option.name = @"JG的讨论组";
        for (NIMGroupUser *userId in self.selectedArr) {
            [self.idArr addObject:userId.memberId];
        }
        [[NIMSDK sharedSDK].teamManager createTeam:option users:self.idArr completion:^(NSError * _Nullable error, NSString * _Nullable teamId) {
            
        }];
        [SVProgressHUD dismissWithDelay:2];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - lazyloading
- (UITableView *)contactList{
    if (!_contactList) {
        UITableView *tab = [[UITableView alloc]init];
        [self.view addSubview:tab];
        [tab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(kMarginTopHeight);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        tab.delegate = self;
        tab.dataSource = self;
        tab.allowsMultipleSelection = YES;
        [tab registerClass:[JGContactListCell class] forCellReuseIdentifier:KContactListCell];
        _contactList = tab;
    }
    return _contactList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JGContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:KContactListCell];
    cell.nickLab.text = ((NIMKitInfo *)((NIMGroupUser *)self.arrData[indexPath.row])).showName;
    if ([self.selectedArr containsObject:self.arrData[indexPath.row]]) {
        cell.selectImage.image = [UIImage imageNamed:@"deleteMember"];
    }else{
        cell.selectImage.image = [UIImage imageNamed:@"addMember"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JGContactListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self addProductsAnimation:cell.selectImage dropToPoint:CGPointMake(WIDTH, 0) isNeedNotification:NO];
    cell.selectImage.image = [UIImage imageNamed:@"deleteMember"];
    [self.selectedArr addObject:self.arrData[indexPath.row]];
    
    if (self.selectedArr.count > 0) {
        [self.rightBut setTitle:[NSString stringWithFormat:@"聊天%ld",self.selectedArr.count] forState:UIControlStateNormal];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    JGContactListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImage.image = [UIImage imageNamed:@"addMember"];
    if (self.selectedArr.count > 0) {
        [self.selectedArr removeObject:self.arrData[indexPath.row]];
    }
    
    if (self.selectedArr.count > 0) {
        [self.rightBut setTitle:[NSString stringWithFormat:@"聊天%ld",self.selectedArr.count] forState:UIControlStateNormal];
    }else{
        [self.rightBut setTitle:@"取消" forState:UIControlStateNormal];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


#pragma mark - 获取我的好友列表
- (void)getMyFriendsList{
    NSMutableArray *data = [[NIMSDK sharedSDK].userManager.myFriends mutableCopy];
    NSMutableArray *myFriendArray = [[NSMutableArray alloc] init];
    for (NIMUser *user in data) {
        [myFriendArray addObject:user.userId];
    }
    NSArray *uids = [self filterData:myFriendArray];
    //    self.data = [self makeUserInfoData:uids];
    NSMutableArray *members = [[NSMutableArray alloc] init];
    for (NSString *uid in uids) {
        NIMGroupUser *user = [[NIMGroupUser alloc] initWithUserId:uid];
        [members addObject:user];
    }
    _arrData = members;
}

- (NSArray *)filterData:(NSMutableArray *)data{
    if (data) {
        if ([self.config respondsToSelector:@selector(filterIds)]) {
            NSArray *ids = [self.config filterIds];
            [data removeObjectsInArray:ids];
        }
        return data;
    }
    return nil;
}



#pragma mark - 执行动画
- (void)addProductsAnimation:(UIImageView *)imageView dropToPoint:(CGPoint)dropToPoint isNeedNotification:(BOOL)isNeedNotification {
    
    //若正在做动画，就结束，防止连续点击
    if (self.isAnimating) {
        return;
    }
    
    self.isAnimating = YES;
    
    self.isNeedNotification = isNeedNotification;
    if (self.animationLayers == nil) {
        self.animationLayers = [[NSMutableArray alloc] init];
    }
    
    CGRect frame = [imageView convertRect:imageView.bounds toView:self];
    CALayer *transitionLayer = [[CALayer alloc] init];
    transitionLayer.frame = frame;
    transitionLayer.contents = imageView.layer.contents;
    [self.view.layer addSublayer:transitionLayer];
    [self.animationLayers addObject:transitionLayer];
    
    CGPoint point1 = transitionLayer.position;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, point1.x, point1.y);
    CGPathAddCurveToPoint(path, nil, point1.x, point1.y - 30, dropToPoint.x, point1.y - 30, dropToPoint.x, dropToPoint.y);
    positionAnimation.path = path;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0.9;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"cartParabola"];
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    self.isAnimating = NO;
    
    if (self.animationLayers.count > 0) {
        CALayer *layer = self.animationLayers[0];
        layer.hidden = YES;
        [layer removeFromSuperlayer];
        [self.animationLayers removeObjectAtIndex:0];
        [self.view.layer removeAnimationForKey:@"cartParabola"];
        if (self.isNeedNotification) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shopCarAnimationEnd" object:nil];
        }
    }
}

@end
