//
//  BoxColor.h
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxColor : NSObject

UIColor *occupiedColor();

UIColor *transformColor(NSString *string);

void changeColor(NSString *string);

@end
