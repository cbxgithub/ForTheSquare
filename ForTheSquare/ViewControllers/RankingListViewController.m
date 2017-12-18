//
//  RankingListViewController.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "RankingListViewController.h"
#import "CustomButton.h"
#import "ChooseLevelViewController.h"
#import "RankingCell.h"

static float cellHeight = 60;

@interface RankingListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CustomButton *backBtn;
@property (nonatomic, strong) CustomButton *enterBtn;

@end

@implementation RankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(50);
        make.height.equalTo(@(cellHeight * 7));
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(self.view).offset(30);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"排行榜";
        _titleLabel.textColor = RGB(74, 74, 74);
        _titleLabel.font = [UIFont systemFontOfSize:28];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
        [_enterBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_enterBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ChooseLevelViewController *vc = [[ChooseLevelViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _enterBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[RankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        cell.level = -1;
        cell.stepCount = -1;
    }else{
        cell.level = indexPath.row + 1;
        cell.stepCount = 20;
    }
    
    return cell;
}


@end
