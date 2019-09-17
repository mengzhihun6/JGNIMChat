//
//  NHTeamMemberSelectNavView.m
//  NestHouse
//
//  Created by JG on 2017/4/21.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHTeamMemberSelectNavView.h"
#import "NHTeamMemberNavCell.h"

#define TEAMNAVCELL @"teamNavCell"
@interface NHTeamMemberSelectNavView()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation NHTeamMemberSelectNavView


- (void)setDataArry:(NSMutableArray *)dataArry{
    _dataArry = dataArry;
    
    if (_dataArry.count < 6) {
        self.memberCollectionView.frame = CGRectMake(0, 0, dataArry.count * (30 + W(5)), 30);
        
        self.searchTextField.frame = CGRectMake(dataArry.count * (30 + W(5)), 0, W(200) - dataArry.count * (30 + W(5)), 30);
    }
    
    [self.memberCollectionView reloadData];

}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 绘制UI
- (void)setupUI{
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(30, 30);
    layOut.minimumLineSpacing = W(5);
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.memberCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 30) collectionViewLayout:layOut];
    self.memberCollectionView.delegate = self;
    self.memberCollectionView.dataSource = self;
    [self.memberCollectionView registerClass:[NHTeamMemberNavCell class] forCellWithReuseIdentifier:TEAMNAVCELL];
    [self addSubview:self.memberCollectionView];
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, W(200), 30)];
    self.searchTextField.placeholder = @"搜索";
    [self addSubview:self.searchTextField];
    

}

#pragma mark - photoCollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NHTeamMemberNavCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TEAMNAVCELL forIndexPath:indexPath];
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_delegate respondsToSelector:@selector(selectNavCollectionCell)]) {
        [_delegate selectNavCollectionCell];
    }
    
    [_dataArry removeLastObject];
    if (_dataArry.count < 6) {
        self.memberCollectionView.frame = CGRectMake(0, 0, _dataArry.count * (30 + W(5)), 30);
        
        self.searchTextField.frame = CGRectMake(_dataArry.count * (30 + W(5)), 0, W(200) - _dataArry.count * (30 + W(5)), 30);
    }
    
    [self.memberCollectionView reloadData];
    
}



@end
