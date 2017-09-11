
//
//  STListFilterView.m
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "STListFilterView.h"
#import "STListFilterViewCell.h"
#import "STListFilterHeadView.h"
#import "STlistFilterFootView.h"
#import "UIColor+STMyIColor.h"

@interface STListFilterView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,STlistFilterFootViewDelegte>{
    NSArray *titleAry;
    BOOL isFilter;
}
@property(strong,nonatomic)UICollectionView *filterCollectionV;
@property(strong,nonatomic)UICollectionViewFlowLayout *filterFlowL;
@end

@implementation STListFilterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        isFilter = YES;
        titleAry = @[@[@{@"不限":@"NO"},@{@"首推联盟":@"YES"},@{@"普药":@"NO"}],@[@{@"不限":@"YES"},@{@"加价购":@"NO"},@{@"包邮":@"NO"}],@[@{@"不限":@"YES"},@{@"0-20%":@"NO"},@{@"20-40%":@"NO"},@{@"40-60%":@"NO"},@{@"60-80%":@"NO"},@{@"80-100%":@"NO"}],@[@{@"不限":@"YES"},@{@"0-20":@"NO"},@{@"20-40":@"NO"},@{@"40-60":@"NO"},@{@"60-80":@"NO"},@{@"80-100":@"NO"},@{@"100以上":@"NO"}]];
        
        [self addTheCollectionView];
    }
    return self;
}
-(void)addTheCollectionView{
    _filterFlowL = [UICollectionViewFlowLayout new];
    _filterFlowL.minimumInteritemSpacing = 1.f;
    [_filterFlowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _filterCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_filterFlowL];
    _filterCollectionV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _filterCollectionV.delegate = self;
    _filterCollectionV.dataSource = self;
    
    [_filterCollectionV registerClass:[STListFilterViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
    
    [_filterCollectionV registerClass:[STListFilterHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeadView"];
    
     [_filterCollectionV registerClass:[STlistFilterFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FilterFootView"];
    
    [self addSubview:_filterCollectionV];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self                                                                                    action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_filterCollectionV addGestureRecognizer:recognizer];
}

#pragma mark --UICollectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return titleAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [titleAry[section]count];
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    STListFilterViewCell *MyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    [MyCell setFilterIndexPath:indexPath andFilter:isFilter andTitleAry:titleAry];
    return MyCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width/3 - 15, 30);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
        if (section == 0) {
            return CGSizeMake(self.frame.size.width,78);
        }else{
    return CGSizeMake(self.frame.size.width,30);
        }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeadView" forIndexPath:indexPath];
        
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.section == 0) {
        STListFilterHeadView *headerView = [STListFilterHeadView new];
        headerView.frame = CGRectMake(0, 0, self.frame.size.width, 78);
        [headerView setFilterTitle:@[@"筛选条件\n\n商品类型",@"促销",@"毛利率",@"零售价格"][indexPath.section] andIndex:indexPath.section];
        [reusableView addSubview:headerView];
        }else{
        STListFilterHeadView *headerView = [STListFilterHeadView new];
        headerView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
        [headerView setFilterTitle:@[@"商品类型",@"促销",@"毛利率",@"零售价格"][indexPath.section] andIndex:indexPath.section];
        [reusableView addSubview:headerView];
        }
        return reusableView;
    }else if(kind == UICollectionElementKindSectionFooter){
            UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FilterFootView" forIndexPath:indexPath];
        
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        
            STlistFilterFootView *footerView = [STlistFilterFootView new];
            footerView.frame = CGRectMake(0, 0, self.frame.size.width, 60);
            footerView.delegate = self;
            [footerView setAddBtn];
            [reusableView addSubview:footerView];
        return reusableView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 3) {
         return CGSizeMake(self.frame.size.width,60);
    }
    return  CGSizeMake(self.frame.size.width,0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    isFilter = NO;
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:indexPath.section];
    [_filterCollectionV reloadSections:indexSet];
    
    STListFilterViewCell *cell = (STListFilterViewCell *)[_filterCollectionV cellForItemAtIndexPath:indexPath];
    cell.titleLab.textColor = [UIColor fromHexValue:0xea5413 alpha:1];
    cell.layer.borderColor = [UIColor fromHexValue:0xea5413 alpha:1].CGColor;
    cell.layer.borderWidth = 1.0f;
}

#pragma STlistFilterFootViewDelegte

-(void)g_setFinished{
    if (_delegate && [_delegate respondsToSelector:@selector(g_setSelecetFilter:)]) {
        [_delegate g_setSelecetFilter:nil];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    if (_delegate && [_delegate respondsToSelector:@selector(g_setSelecetFilter:)]) {
        [_delegate g_setSelecetFilter:nil];
    }
};
@end
