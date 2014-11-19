//
//  ContactDAO.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-6.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ContactDAO.h"

@implementation ContactDAO
-(void)findFriendByID:(NSString*)friendID{
    
};
-(void)findFriendByPhone:(NSString*)phone{
    
};

-(void)addFriendByID:(NSString*)friendID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addFriend&friend_id=%@",friendID];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        NSDictionary* dict=[operation.responseString objectFromJSONString];
        int result=        [[dict objectForKey:@"result"] intValue];

            [_delegate addFriendByIDSuccess:(NSInteger)result];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
    
};
-(void)addFriendByPhone:(NSString*)phone{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                       = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=addFriend&friend_phone=%@",phone];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        NSDictionary* dict=[operation.responseString objectFromJSONString];
        NSInteger status=[[dict objectForKey:@"result"] integerValue];
        [_delegate addFriendByPhoneSuccess:status];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
    
};
-(void)acceptFriend:(NSString*)friendID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=acceptFriend&friend_id=%@",friendID];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Accept-Friend-JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        [_delegate acceptFriendSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
-(void)rejectFriend:(NSString*)friendID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=rejectFriend&friend_id=%@",friendID];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        //        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
-(void)delFriend:(NSString*)friendID{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=delFriend&friend_id=%@",friendID];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        NSDictionary*dict=[operation.responseString objectFromJSONString];
NSString* status=        [dict objectForKey:@"result"];
        //编辑成功BL的delegate editSuccess
        [_delegate delFriendByIDSuccess:[status intValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
-(void)getFriends:(NSString*)page perPage:(NSString*)perPage{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getFriends&page=%@&per_page=%@",page,perPage];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        NSArray* friends=[self jsonToFriendArray:operation.responseString];
        //编辑成功BL的delegate editSuccess
        [_delegate getFriendsSuccess:friends];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
-(void)getMyFriendRequests:(NSString*)page perPage:(NSString*)perPage{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getMyRequests&page=%@&per_page=%@",page,perPage];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        //        [_delegate editUserInfoSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
/**
 *  我的待接受好友列表
 *
 *  @param page    分为page页
 *  @param perPage 每页有perPage项内容
 */
-(void)getMyAccepts:(NSString*)page perPage:(NSString*)perPage{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getMyAccepts&page=%@&per_page=%@",page,perPage];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Accept-Friend-JSON: %@", operation.responseString);
        //        [self jsonToFriendArray:operation.responseString];
        //编辑成功BL的delegate editSuccess
        [_delegate getAcceptFriendSuccess:[self jsonToFriendArray:operation.responseString]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
};
-(void)scanFriend:(NSString *)longitude withLatitude:(NSString *)latitude{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=scan&longitude=%@&latitude=%@",longitude,latitude];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Scan-Friend-JSON: %@", operation.responseString);
        //编辑成功BL的delegate editSuccess
        [_delegate scanFriendSuccess:[self jsonToFriendArray:operation.responseString]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
}
-(void)stopScanFriend{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=stopScan"];
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
    
}
/**
 *  获得好友运动排行
 *
 *  @param date 运动排行的日期
 */
-(NSArray*)getFriendSportRank:(NSString*)date{
    //    __block NSArray* rankFriend;
    //    __block NSDictionary* dict;
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getFriendDurations&date=%@",date];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"JSON: %@", operation.responseString);
        NSDictionary* dict=[operation.responseString objectFromJSONString];
        NSArray* rankFriend=[dict objectForKey:@"list"];
        //编辑成功BL的delegate editSuccess
        [_delegate getSportRankSuccess:rankFriend];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
    
    //    rankFriend=[dict objectForKey:@"list"];
    return nil;
};
/**
 *  获得众筹好友
 */
-(void)getCrowdfundFriends:(NSString*)expiredTime{
    AFHTTPRequestOperationManager *manager           = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer                      = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie]forHTTPHeaderField:@"Cookie"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSString* suffix=[NSString stringWithFormat:@"?m=user&a=getFriends&crowdfund_expire_time=%@",expiredTime];
    NSString* requestUrl                             =[BaseURLString stringByAppendingString:suffix];
    
    NSString* utf8=[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将请求地址转换为utf8编码，使用默认unicode进行请求会报编码错误
    [manager POST:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"crowdfund-friend-JSON: %@", operation.responseString);
        NSArray* friends=[self jsonToFriendArray:operation.responseString];
        //编辑成功BL的delegate editSuccess
        [_delegate getCrowdfundFriendSuccess:friends];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //编辑失败BL的delegate editFail
        //        [_delegate editUserInfoFail];
    }];
};
-(NSArray*)jsonToFriendArray:(NSString*)json{
    NSDictionary* dict=[json objectFromJSONString];
    NSArray* friends=[dict objectForKey:@"list"];
    return friends;
}
@end
