//
//  RankingCell.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/18.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "RankingCell.h"

@interface RankingCell()

@property (nonatomic, strong) UILabel *levelLabel;

@property (nonatomic, strong) UILabel *stepLabel;

@end

@implementation RankingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void) initSubviews {
    
    @weakify(self);
    [self addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self);
        make.left.equalTo(@70);
    }];
    
    
    [self addSubview:self.stepLabel];
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.height.equalTo(self);
        make.right.equalTo(@-70);
    }];
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.font = [UIFont systemFontOfSize:20];
        _levelLabel.textColor = RGB(155, 155, 155);
    }
    return _levelLabel;
}

- (UILabel *)stepLabel {
    if (!_stepLabel) {
        _stepLabel = [[UILabel alloc] init];
        _stepLabel.font = [UIFont systemFontOfSize:20];
        _stepLabel.textColor = RGB(155, 155, 155);
    }
    return _stepLabel;
}

- (void)setLevel:(NSInteger)level {
    _level = level;
    
    if (level == -1) {
        self.levelLabel.text = [NSString stringWithFormat:@"关卡"];
    }else{
        self.levelLabel.text = [NSString stringWithFormat:@"1-%ld",(level+1)];
    }
    
    [self.levelLabel sizeToFit];
}

- (void)setStepCount:(NSInteger)stepCount {
    _stepCount = stepCount;
    
    if (stepCount == -1) {
        self.stepLabel.text = [NSString stringWithFormat:@"步数"];
    }else if(stepCount == 0){
        self.stepLabel.text = [NSString stringWithFormat:@"未通过"];
    }else {
        self.stepLabel.text = [NSString stringWithFormat:@"%ld",stepCount];
    }
    
    [self.stepLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
