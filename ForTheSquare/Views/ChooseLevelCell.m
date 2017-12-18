//
//  ChooseLevelCell.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/18.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "ChooseLevelCell.h"

@interface ChooseLevelCell()

@property (nonatomic, strong) UIView *imageContainer;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *levelNameLabel;

@end

@implementation ChooseLevelCell{
    UIColor *highlightColor;
    UIColor *normalColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        highlightColor = RGB(244,89,27);
        normalColor = RGB(97, 97, 97);
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.imageContainer];
    @weakify(self);
    [self.imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.top.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@100);
    }];
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self.imageContainer);
        make.width.height.equalTo(@66);
    }];
    
    [self addSubview:self.levelNameLabel];
    [self.levelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.imageContainer.mas_bottom).offset(20);
        make.width.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [[self rac_valuesForKeyPath:@"selected" observer:self] subscribeNext:^(id  _Nullable x) {
        BOOL isSelected = [x boolValue];
        if (isSelected) {
            self.imageContainer.layer.borderColor = highlightColor.CGColor;
            self.levelNameLabel.textColor = highlightColor;
        }else{
            self.imageContainer.layer.borderColor = normalColor.CGColor;
            self.levelNameLabel.textColor = normalColor;
        }
    }];
}

- (UIView *)imageContainer{
    if (!_imageContainer) {
        _imageContainer = [[UIView alloc] init];
        _imageContainer.layer.borderWidth = 1;
        _imageContainer.layer.borderColor = normalColor.CGColor;
    }
    return _imageContainer;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"icon"];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UILabel *)levelNameLabel{
    if (!_levelNameLabel) {
        _levelNameLabel = [[UILabel alloc] init];
        _levelNameLabel.text = @"1-1";
        _levelNameLabel.font = [UIFont systemFontOfSize:20];
        _levelNameLabel.textAlignment = NSTextAlignmentCenter;
        _levelNameLabel.textColor = normalColor;
    }
    return _levelNameLabel;
}

- (void)setLevel:(NSInteger)level{
    _level = level;
    self.levelNameLabel.text = [NSString stringWithFormat:@"1-%ld",level];
}

@end
