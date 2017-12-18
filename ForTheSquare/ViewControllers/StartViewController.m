//
//  StartViewController.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "StartViewController.h"
#import "CustomButton.h"
#import "ChooseLevelViewController.h"
#import "RuleViewController.h"
#import "RankingListViewController.h"

@interface StartViewController ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CustomButton *startBtn;
@property (nonatomic, strong) CustomButton *ruleBtn;
@property (nonatomic, strong) CustomButton *rankingBtn;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubviews];
}

- (void)initSubviews {
    
    @weakify(self);
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.height.equalTo(@66);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@133);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.ruleBtn];
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.startBtn.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.rankingBtn];
    [self.rankingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.ruleBtn.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"icon"];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"King Of The Box";
        _titleLabel.textColor = RGB(74, 74, 74);
        _titleLabel.font = [UIFont systemFontOfSize:28];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (CustomButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [[CustomButton alloc] init];
        [_startBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
        [_startBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_startBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_startBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ChooseLevelViewController *vc = [[ChooseLevelViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _startBtn;
}

- (CustomButton *)ruleBtn {
    if (!_ruleBtn) {
        _ruleBtn = [[CustomButton alloc] init];
        [_ruleBtn setTitle:@"规则说明" forState:UIControlStateNormal];
        [_ruleBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_ruleBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_ruleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            RuleViewController *vc = [[RuleViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _ruleBtn;
}

- (CustomButton *)rankingBtn {
    if (!_rankingBtn) {
        _rankingBtn = [[CustomButton alloc] init];
        [_rankingBtn setTitle:@"排行榜" forState:UIControlStateNormal];
        [_rankingBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_rankingBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_rankingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            RankingListViewController *vc = [[RankingListViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _rankingBtn;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = @"占领盒子成为盒子之王";
        _descriptionLabel.textColor = RGB(74, 74, 74);
        _descriptionLabel.font = [UIFont systemFontOfSize:13];
    }
    return _descriptionLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
