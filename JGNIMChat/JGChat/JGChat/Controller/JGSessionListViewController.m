//
//  JGSessionListViewController.m
//  JGChat
//
//  Created by JG on 2017/5/11.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGSessionListViewController.h"
//联系人控制器
#import "JGContactListController.h"
#import "NHSessionViewController.h"


@interface JGSessionListViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UIButton *rightBut;

@end

@implementation JGSessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBarIteam];
    [self check3DTouch];
    [self headerAndFooter];
}


#pragma mark - setRightBarIteam
- (void)setRightBarIteam{
    self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBut.frame = CGRectMake(0, 7, 50, 30);
    [self.rightBut setTitle:@"聊天" forState:UIControlStateNormal];
    [self.rightBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBut addTarget:self action:@selector(rightButClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBut];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 可以自定义footer 和header
- (void)headerAndFooter{

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    lab.backgroundColor = [UIColor greenColor];
    lab.text = @"自定义footer和header";
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = lab;
    self.tableView.tableHeaderView.height = 100;
    
}

- (void)rightButClick{
    
    JGContactListController *vc = [[JGContactListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)onSelectedRecent:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{
    NHSessionViewController *vc = [[NHSessionViewController alloc]initWithSession:recent.session];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 父类方法中，判断有无最近消息，如果无，则tableView隐藏，这里因为有headerView，所有要重写
- (void)reload{
    [self.tableView reloadData];
}

- (void)check3DTouch {
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {//3DTouch可用
        //注册协议
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else {//3DTouch不可用
        NSLog(@"3DTouch不可用");
    }
}

#pragma mark - UIViewControllerPreviewingDelegate 进入预览模式 peek 预览控制器

/**
 深按控制器的时候会走该方法 返回想要预览的控制器
 
 @param previewingContext 上下文
 @param location 点按的point
 @return 返回想要预览的控制器 可以为nil
 */
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    //通过[previewingContext sourceView]拿到对应的cell的数据；
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    NHSessionViewController *peekVc = [[NHSessionViewController alloc] initWithSession:((NIMRecentSession *)self.recentSessions[indexPath.row]).session];
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面(peek)
    CGFloat h = 50;
    CGFloat y = (self.view.height - h) * 0.5;
    CGRect sourceRect = CGRectMake(0, y, self.tableView.width, h);
    //sourceRect就是不被虚化的区域
    previewingContext.sourceRect = sourceRect;
    
    return peekVc;
}
//继续按压进入：实现该协议 pop（按用点力进入）
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    //跳转到预览控制器
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    //    [self.navigationController showDetailViewController:viewControllerToCommit sender:self];
}
- (void)unregisterForPreviewingWithContext:(id<UIViewControllerPreviewing>)previewing
{
    NSLog(@"unregisterForPreviewingWithContext");
}

@end
