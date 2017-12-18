//
//  BoxColor.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/15.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "BoxColor.h"

static NSString *const kColorKey = @"colorkey";


@implementation BoxColor

UIColor *occupiedColor() {
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kColorKey]) {
        
        NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kColorKey];
        NSArray *strings = [string componentsSeparatedByString:@","];
        return RGB([strings[0] integerValue], [strings[1] integerValue], [strings[2] integerValue]);
    }
    return RGB(244, 89, 27);
}

UIColor *transformColor(NSString *string) {
    
    NSArray *strings = [string componentsSeparatedByString:@","];
    return RGB([strings[0] integerValue], [strings[1] integerValue], [strings[2] integerValue]);
}

void changeColor(NSString *string) {
    
    [[NSUserDefaults standardUserDefaults] setValue:string forKey:kColorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
