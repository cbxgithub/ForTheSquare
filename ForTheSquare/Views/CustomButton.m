//
//  CustomButton.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/17.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "CustomButton.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIView+QTAdd.h"

@implementation CustomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

//初始化按钮的一些数据
- (void)initSubViews{
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGB(155, 155, 155).CGColor;
    self.backgroundColor = [UIColor clearColor];
    
    [[self rac_valuesForKeyPath:@"highlighted" observer:self] subscribeNext:^(id  _Nullable x) {
        BOOL isHighlighted = [x boolValue];
        if (isHighlighted) {
            self.layer.borderColor = _highlightColor.CGColor;
        }else{
            self.layer.borderColor = RGB(155, 155, 155).CGColor;
        }
    }];
    
}

- (UIColor *)highlightColor {
    if (!_highlightColor) {
        _highlightColor = RGB(74, 74, 74);
    }
    return _highlightColor;
}


@end
