//
//  RuleViewController.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "RuleViewController.h"
#import "CustomButton.h"
#import "ChooseLevelViewController.h"

@interface RuleViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *ruleLabel;

@property (nonatomic, strong) CustomButton *backBtn;
@property (nonatomic, strong) CustomButton *enterBtn;

@end

@implementation RuleViewController{
    float margin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    margin = 30;
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
    
    [self.view addSubview:self.ruleLabel];
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.ruleLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(margin);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self.view addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.ruleLabel.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-margin);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"游戏规则";
        _titleLabel.textColor = RGB(74, 74, 74);
        _titleLabel.font = [UIFont systemFontOfSize:28];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)ruleLabel {
    if (!_ruleLabel) {
        _ruleLabel = [[UILabel alloc] init];
        _ruleLabel.text = @"1. 每个方块都有两个状态，即free状态（白色方块）以及occupied状态（颜色方块）。\n2. 初始状态都为free状态，当方块被点击，那么该方块的当前状态会变为对立状态，即：变色。\n3. 同时该方块相邻（不包含对角线相邻的方块）的方块状态也会变化，当所有的方块都变为occupied状态时游戏结束。\n4. 尽量去挑战更多阶数的游戏难度吧~";
        _ruleLabel.numberOfLines = 0;
        _ruleLabel.textColor = RGB(155, 155, 155);
        _ruleLabel.font = [UIFont systemFontOfSize:14];
        _ruleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _ruleLabel;
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
        [_enterBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_enterBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        
        if (self.isFromGame) {
            [_enterBtn setTitle:@"继续游戏" forState:UIControlStateNormal];
            [[_enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }else {
            [_enterBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
            [[_enterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                ChooseLevelViewController *vc = [[ChooseLevelViewController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }];
        }
    }
    return _enterBtn;
}

- (void)setIsFromGame:(BOOL)isFromGame{
    _isFromGame = isFromGame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
