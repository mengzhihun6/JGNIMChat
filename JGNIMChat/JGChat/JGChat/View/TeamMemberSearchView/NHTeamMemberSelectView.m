//
//  NHTeamMemberSelectView.m
//  NestHouse
//
//  Created by JG on 2017/4/21.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHTeamMemberSelectView.h"
#import "NHTeamMemberSelectCell.h"
#import "NIMContactDefines.h"
#import "NIMGroupedUsrInfo.h"

@interface NHTeamMemberSelectView()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableOrderedSet *_specialGroupTtiles;
    NSMutableOrderedSet *_specialGroups;
    NSMutableOrderedSet *_groupTtiles;
    NSMutableOrderedSet *_groups;
}

@property(nonatomic,strong)NSMutableArray *array;//数据源

@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据


@end
@implementation NHTeamMemberSelectView

//- (void)setArr:(NSArray *)arr{
//    _arr = arr;
//    if (self.selectorPatnArray.count > 0) {
//        [self.selectorPatnArray removeLastObject];
//    }
//    [self.memberTab reloadData];
//}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        _specialGroupTtiles = [[NSMutableOrderedSet alloc] init];
        _specialGroups = [[NSMutableOrderedSet alloc] init];
        _groupTtiles = [[NSMutableOrderedSet alloc] init];
        _groups = [[NSMutableOrderedSet alloc] init];
    }
    return self;
}

#pragma mark -懒加载

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray *)selectorPatnArray{
    if (!_selectorPatnArray) {
        _selectorPatnArray = [NSMutableArray array];
    }
    return _selectorPatnArray;
}


#pragma mark - 绘制UI
- (void)setupUI{
    
    //添加数据源
    for (int i = 0; i < 100; i++) {
        NSString *str = [NSString stringWithFormat:@"第%d行",i + 1];
        [self.array addObject:str];
    }

    self.memberTab = [[UITableView alloc]initWithFrame:self.bounds];
    self.memberTab.delegate = self;
    self.memberTab.dataSource = self;
    self.memberTab.allowsMultipleSelection = YES;
    [self addSubview:self.memberTab];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NHTeamMemberSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[NHTeamMemberSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.nameLab.text = [NSString stringWithFormat:@"MRS巢宅家舍%ld",indexPath.row];
    cell.nameLab.text = ((NIMKitInfo *)((NIMGroupUser *)self.arr[indexPath.row])).showName;
    if ([self.selectorPatnArray containsObject:indexPath]) {
        cell.selectImageView.image = [UIImage imageNamed:@"评论-点赞"];
    }else{
        cell.selectImageView.image = [UIImage imageNamed:@"发送"];
    }
    
    
    return  cell;
}
//取消选择cell
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.selectorPatnArray.count > 0) {
        
        [self.selectorPatnArray removeObject:self.arr[indexPath.row]];
    }
    DLog(@"!!!!!!!!!!!!!!!%@",self.selectorPatnArray);
    
    NHTeamMemberSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.image = [UIImage imageNamed:@"发送"];
    
    if ([_delegate respondsToSelector:@selector(unSelect:selectedArr:)]) {
        [_delegate unSelect:self selectedArr:self.selectorPatnArray];
    }
}
//选择cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选中数据
    [self.selectorPatnArray addObject:self.arr[indexPath.row]];
    
    DLog(@"******************%@",self.selectorPatnArray);
    
    NHTeamMemberSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.image = [UIImage imageNamed:@"评论-点赞"];
    
    if ([_delegate respondsToSelector:@selector(didSelect:selectedArr:)]) {
        [_delegate didSelect:self selectedArr:self.selectorPatnArray];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return H(40);
}



- (void)setMembers:(NSArray *)members
{
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    NSString *me = [[NIMSDK sharedSDK].loginManager currentAccount];
    for (id<NIMGroupMemberProtocol>member in members) {
        if ([[member memberId] isEqualToString:me]) {
            continue;
        }
        NSString *groupTitle = [member groupTitle];
        NSMutableArray *groupedMembers = [tmp objectForKey:groupTitle];
        if(!groupedMembers) {
            groupedMembers = [NSMutableArray array];
        }
        [groupedMembers addObject:member];
        [tmp setObject:groupedMembers forKey:groupTitle];
    }
    [_groupTtiles removeAllObjects];
    [_groups removeAllObjects];
    self.arr = members.mutableCopy;
    [self.memberTab reloadData];
    
    
}

@end
