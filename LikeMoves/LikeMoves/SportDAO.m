//
//  SportDAO.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SportDAO.h"

@implementation SportDAO
/**
 *  添加运动时间，运动时长
 *
 *  @param duration 运动的时长，秒钟
 */
-(void) addMoveRecord:(NSTimeInterval)duration{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a= addMoveRecord&duration=%f",duration];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
//        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
//        [_delegate editUserInfoFail];
    }];
    
};
/**
 *  查询过去7天的运动记录，返回内容？
 *
 *  @param startTime 开始时间：2014-09-07
 *  @param endTime   结束时间：2014-09-07
 */
-(void) getMoveRecord:(NSString*)startTime withEndTime:(NSString*)endTime{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a= getMoveRecords&start_time=%@&end_time=%@",startTime,endTime];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
//        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
//        [_delegate editUserInfoFail];
    }];
    
};
/**
 *  获得月份的运动天数
 *
 *  @param month @“2014-09”月份格式
 */
-(void) getMonthMoveDays:(NSString*)month{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getMonthMoveDays&month=%@",month];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
//        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
//        [_delegate editUserInfoFail];
    }];
    
};

@end
