//
//  YYCoreData.m
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "YYCoreData.h"

@implementation YYCoreData

+(YYCoreData *)shareCoreData
{
    static YYCoreData * CoreData = nil;
    static dispatch_once_t data_api;
    
    dispatch_once(&data_api, ^{
        CoreData = [[YYCoreData alloc]init];
    });
    return CoreData;
}

-(void)createRootDirectoryIfNeed
{
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    BOOL succ = [fileMgr createDirectoryAtPath:[self userRootDocDir] withIntermediateDirectories:YES attributes:nil error:nil];
    if (succ) {
        NSLog(@"创建用户路径成功：%@",[self userRootDocDir]);
    }else{
        NSLog(@"创建用户路径失败：%@",[self userRootDocDir]);
    };
}

-(NSString *)userRootDocDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
    NSLog(@"噢噢噢噢 = %@",documentsDirectory);
    NSString *userName = @"search";
    return [documentsDirectory stringByAppendingPathComponent:userName];
}

/**
 *  生成 在用户跟目录下的文件路径信息
 *
 *  @param relativePath 相对路径 eg: test.plist or game/test.plist
 *
 *  @return 绝对路径
 */
-(NSString *)userResPath:(NSString *)relativePath
{
    [self createRootDirectoryIfNeed];
    NSString * path = [[self userRootDocDir] stringByAppendingPathComponent:relativePath];
    return path;
}

@end
