//
//  ViewController.m
//  JGChat
//
//  Created by JG on 2017/5/11.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "ViewController.h"
#import "JGSessionListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(100, 200, 100, 50);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"进入" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

#pragma mark - 点击进入
- (void)butClick{
    
    [[[NIMSDK sharedSDK] loginManager] login:@"h2"
                                       token: @"111111"
                                  completion:^(NSError *error) {
                                      
                                      if (error == nil){

                                          JGSessionListViewController *vc = [[JGSessionListViewController alloc]init];
                                          [self.navigationController pushViewController:vc animated:YES];
                                          
                                      }else{
                                          NSLog(@"失败");
                                      }
                                  }];
    
}


@end
