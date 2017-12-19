//
//  RankDB.h
//  ForTheSquare
//
//  Created by cbx on 2017/12/19.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankModel.h"
#import <FMDB/FMDB.h>

@interface RankDB : NSObject

@property (nonatomic, strong) FMDatabase *db;

+ (void)updateRankWith:(NSString *)levelName andStepCount:(NSString *)stepCount;

+ (NSArray<RankModel *> *)getRankList;

+ (NSInteger)getstepCountWith:(NSString *)levelName;

+ (instancetype)sharedInstance;

@end
