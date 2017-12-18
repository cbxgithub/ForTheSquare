//
//  ChooseLevelViewController.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "ChooseLevelViewController.h"
#import "ChooseLevelCell.h"
#import "CustomButton.h"
#import "GameViewController.h"

static NSString * const  cellIdentifier  = @"cellIdentifier";
static const float       itemWidth       = 100.0f;
static const float       itemHeight      = 150.0f;

@interface ChooseLevelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

@property (nonatomic, strong) CustomButton *backBtn;
@property (nonatomic, strong) CustomButton *enterBtn;

@property (nonatomic, assign) NSInteger seletedIndex;

@end

@implementation ChooseLevelViewController{
    float margin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    margin = (self.view.bounds.size.width - itemWidth * 2)/3;
    self.seletedIndex = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
}

- (void)initSubviews {
    
    @weakify(self);
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(@40);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
    }];
    
    float collectionViewHeight = self.view.frame.size.height - 80 - 30 - 42 - 20 - 30;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.width.equalTo(self.view);
        make.height.equalTo(@(collectionViewHeight));
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(self.view).offset(margin);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.right.equalTo(self.view.mas_right).offset(-margin);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"选择关卡";
        _titleLabel.textColor = RGB(74, 74, 74);
        _titleLabel.font = [UIFont systemFontOfSize:28];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.contentInset = UIEdgeInsetsMake(30, margin, 30, margin);
        
        [_collectionView registerClass:ChooseLevelCell.class forCellWithReuseIdentifier:cellIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionLayout{
    
    if (!_collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        _collectionLayout.minimumInteritemSpacing = 50;
    }
    return _collectionLayout;
}

- (CustomButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[CustomButton alloc] init];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_backBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _backBtn;
}

- (CustomButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [[CustomButton alloc] init];
        [_enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_enterBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            GameViewController *vc = [[GameViewController alloc] init];
            vc.level = self.seletedIndex + 3;
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _enterBtn;
}

# pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setSelected:NO];
    [cell setLevel:indexPath.row+1];
    
    if (indexPath.row == self.seletedIndex) {
        [cell setSelected:YES];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.seletedIndex = indexPath.row;
    
    ChooseLevelCell *firstCell = (ChooseLevelCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if (firstCell.isSelected && indexPath.row!=0) {
        [firstCell setSelected:NO];
    }
}

# pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(itemWidth, itemHeight);
}


@end
