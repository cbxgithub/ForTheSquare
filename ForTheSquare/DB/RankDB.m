//
//  RankDB.m
//  ForTheSquare
//
//  Created by cbx on 2017/12/19.
//  Copyright © 2017年 cbx. All rights reserved.
//

#import "RankDB.h"

@implementation RankDB

+ (instancetype)sharedInstance {
    static RankDB *sharedInstance = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RankDB alloc] init] ;
    });
    return sharedInstance;
}

+ (FMDatabase *)getDB {
    
    if ([RankDB sharedInstance].db) {
        return [RankDB sharedInstance].db;
    }
    // 0.拼接数据库存放的沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlFilePath = [path stringByAppendingPathComponent:@"KB.sqlite"];
    
    // 1.通过路径创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:sqlFilePath];
    
    // 2.打开数据库
    if ([db open]) {
        
        //判断排行榜表中是否有数据
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_kbrank"];
        BOOL isExist = NO;
        while ([rs next]) {
            isExist = YES;
            break;
        }

        //如果不存在，创建这个表，并且为它写入初始数据
        if (!isExist) {
            BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_kbrank (id INTEGER PRIMARY KEY AUTOINCREMENT, levelName TEXT NOT NULL, stepCount TEXT NOT NULL)"];
            if (success) {
                [db executeUpdate:@"INSERT INTO t_kbrank (levelName,stepCount) VALUES('1-1','未过关');"];
                [db executeUpdate:@"INSERT INTO t_kbrank (levelName,stepCount) VALUES('1-2','未过关');"];
                [db executeUpdate:@"INSERT INTO t_kbrank (levelName,stepCount) VALUES('1-3','未过关');"];
                [db executeUpdate:@"INSERT INTO t_kbrank (levelName,stepCount) VALUES('1-4','未过关');"];
                [db executeUpdate:@"INSERT INTO t_kbrank (levelName,stepCount) VALUES('1-5','未过关');"];
                [db executeUpdate:@"INSERT INTO t_kbrank (levelName,stepCount) VALUES('1-6','未过关');"];
            }
        }
        
        [RankDB sharedInstance].db = db;
        return [RankDB sharedInstance].db;
    }
    return nil;
}

+ (void)updateRankWith:(NSString *)levelName andStepCount:(NSString *)stepCount {
    FMDatabase *db = [RankDB getDB];
    
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE t_kbrank SET stepCount = '%@' WHERE levelName = '%@';",stepCount,levelName];
        BOOL success = [db executeUpdate:sql];
        if (success) {
            NSLog(@"更新成功");
        }else{
            NSLog(@"更新失败");
        }
    }
}

+ (NSArray<RankModel *> *)getRankList {
    FMDatabase *db = [RankDB getDB];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_kbrank"];
    NSMutableArray *rankList = @[].mutableCopy;
    while ([rs next]) {
        RankModel *rankModel = [RankModel new];
        rankModel.levelName = [rs stringForColumn:@"levelName"];
        rankModel.stepCount = [rs stringForColumn:@"stepCount"];
        [rankList addObject:rankModel];
    }
    return rankList;
}

+ (NSInteger)getstepCountWith:(NSString *)levelName {

    for (RankModel *rankModel in [RankDB getRankList]) {
        if ([rankModel.levelName isEqualToString:levelName]) {
            return rankModel.stepCount.integerValue;
        }
    }
    return 0;
}

@end
