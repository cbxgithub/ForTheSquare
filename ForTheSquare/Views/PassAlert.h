//
//  PassAlert.h
//  ForTheSquare
//
//  Created by cbx on 2017/12/19.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassAlert : UIView

@property (nonatomic, strong) void(^againBlock)(void);
@property (nonatomic, strong) void(^nextBlock)(void);


+ (void)showWithAgainBlock:(void(^)(void))again NextBlock:(void(^)(void))next;

@end
