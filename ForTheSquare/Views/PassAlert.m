//
//  PassAlert.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/19.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "PassAlert.h"
#import "CustomButton.h"

@interface PassAlert()

@property (nonatomic, strong) UILabel *passLabel;

@property (nonatomic, strong) CustomButton *againBtn;
@property (nonatomic, strong) CustomButton *nextBtn;


@end

@implementation PassAlert

+ (void)showWithAgainBlock:(void (^)(void))again NextBlock:(void (^)(void))next {
    
    PassAlert *passAlert = [[PassAlert alloc] init];
    passAlert.againBlock = again;
    passAlert.nextBlock = next;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:passAlert];
    [passAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@165);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    @weakify(self);
    [self addSubview:self.passLabel];
    [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self);
        make.top.equalTo(@30);
    }];
    
    [self addSubview:self.againBtn];
    [self.againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.left.equalTo(@30);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
    
    [self addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.right.equalTo(@-30);
        make.width.equalTo(@101);
        make.height.equalTo(@42);
    }];
}

- (UILabel *)passLabel {
    if (!_passLabel) {
        _passLabel = [[UILabel alloc] init];
        _passLabel.font = [UIFont systemFontOfSize:20];
        _passLabel.textColor = RGB(97, 97, 97);
        _passLabel.text = @"恭喜你！过关了！";
        [_passLabel sizeToFit];
    }
    return _passLabel;
}

- (CustomButton *)againBtn {
    if (!_againBtn) {
        _againBtn = [[CustomButton alloc] init];
        [_againBtn setTitle:@"再来一次" forState:UIControlStateNormal];
        [_againBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_againBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_againBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.againBlock) {
                self.againBlock();
            }
            [self removeFromSuperview];
        }];
    }
    return _againBtn;
}

- (CustomButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[CustomButton alloc] init];
        [_nextBtn setTitle:@"下一关" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateHighlighted];
        [_nextBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.nextBlock) {
                self.nextBlock();
            }
            [self removeFromSuperview];
        }];
    }
    return _nextBtn;
}

@end
